import { unstable_noStore as noStore } from 'next/cache';
import {
    CustomerField,
    CustomersTableType,
    InvoiceForm,
    InvoicesTable,
    LatestInvoiceRaw,
    User,
    Revenue,
  } from '../lib/definitions';
import { formatCurrency } from '../lib/utils';
  import { executeQuery } from './db';


export async function fetchRevenue() {
    // Add noStore() here to prevent the response from being cached.
    // This is equivalent to in fetch(..., {cache: 'no-store'}).
    // It makes the page dynamic
    noStore();
  
    try {
      // Artificially delay a response for demo purposes.
      // Don't do this in production :)
  
      console.log('Fetching revenue data...');
      await new Promise((resolve) => setTimeout(resolve, 3000));
  
      const data = await executeQuery(`SELECT * FROM revenue`);
  
      console.log('Data fetch completed after 3 seconds.');
  
      return data as Revenue[];
    } catch (error) {
      console.error('Database Error:', error);
      throw new Error('Failed to fetch revenue data.');
    }
  }

  export async function fetchLatestInvoices() {
    noStore();
    try {
      const data = await executeQuery(`
        SELECT invoices.amount, customers.name, customers.image_url, customers.email, invoices.id
        FROM invoices
        JOIN customers ON invoices.customer_id = customers.id
        ORDER BY invoices.date DESC
        LIMIT 5`) as LatestInvoiceRaw[];
  
      const latestInvoices = data.map((invoice) => ({
        ...invoice,
        amount: formatCurrency(invoice.amount),
      }));
      return latestInvoices;
    } catch (error) {
      console.error('Database Error:', error);
      throw new Error('Failed to fetch the latest invoices.');
    }
  }

  export async function fetchCardData() {
    noStore();
    try {
      // You can probably combine these into a single SQL query
      // However, we are intentionally splitting them to demonstrate
      // how to initialize multiple queries in parallel with JS.
      const invoiceCountPromise = executeQuery(`SELECT COUNT(*) FROM invoices`);
      const customerCountPromise = executeQuery(`SELECT COUNT(*) FROM customers`);
      const invoiceStatusPromise = executeQuery(`SELECT
           SUM(CASE WHEN status = 'paid' THEN amount ELSE 0 END) AS "paid",
           SUM(CASE WHEN status = 'pending' THEN amount ELSE 0 END) AS "pending"
           FROM invoices`);
  
      const data = await Promise.all([
        invoiceCountPromise,
        customerCountPromise,
        invoiceStatusPromise,
      ]) as any;
  
      const numberOfInvoices = Number(data[0][0]['COUNT(*)'] ?? '0');
      const numberOfCustomers = Number(data[1][0]['COUNT(*)'] ?? '0');
      const totalPaidInvoices = formatCurrency(data[2][0].paid ?? '0');
      const totalPendingInvoices = formatCurrency(data[2][0].pending ?? '0');
  
      return {
        numberOfCustomers,
        numberOfInvoices,
        totalPaidInvoices,
        totalPendingInvoices,
      };
    } catch (error) {
      console.error('Database Error:', error);
      throw new Error('Failed to fetch card data.');
    }
  }


  const ITEMS_PER_PAGE = 6;
export async function fetchFilteredInvoices(
  query: string,
  currentPage: number,
) {
  const offset = (currentPage - 1) * ITEMS_PER_PAGE;

  try {
    let whereClause = '';
    if (query.trim() !== '') {
      whereClause = `
        WHERE
          customers.name LIKE '%${query}%' OR
          customers.email LIKE '%${query}%' OR
          invoices.amount LIKE '%${query}%' OR
          invoices.date LIKE '%${query}%' OR
          invoices.status LIKE '%${query}%'
      `;
    }

    const invoices = await executeQuery(`
      SELECT
        invoices.id,
        invoices.customer_id,
        invoices.amount,
        invoices.date,
        invoices.status,
        customers.name,
        customers.email,
        customers.image_url
      FROM invoices
      JOIN customers ON invoices.customer_id = customers.id
      ${whereClause}
      ORDER BY invoices.date DESC
      LIMIT ${ITEMS_PER_PAGE} OFFSET ${offset}
    `);

    return invoices as InvoicesTable[];
  } catch (error) {
    console.error('Database Error:', error);
    throw new Error('Failed to fetch invoices.');
  }
}

export async function fetchInvoicesPages(query: string) {
  try {
    let whereClause = '';
    if (query.trim() !== '') {
      whereClause = `
        WHERE
          customers.name LIKE '%${query}%' OR
          customers.email LIKE '%${query}%' OR
          invoices.amount LIKE '%${query}%' OR
          invoices.date LIKE '%${query}%' OR
          invoices.status LIKE '%${query}%'
      `;
    }
    const count = await executeQuery(`SELECT COUNT(*)
    FROM invoices
    JOIN customers ON invoices.customer_id = customers.id` 
    + `${whereClause}`) as Array<{ 'COUNT(*)': number }>;
    
    const totalPages = Math.ceil(Number(count[0]['COUNT(*)']) / ITEMS_PER_PAGE);
    return totalPages;
  } catch (error) {
    console.error('Database Error:', error);
    throw new Error('Failed to fetch total number of invoices.');
  }
}
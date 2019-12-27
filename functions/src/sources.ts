

import {viewOrCreateCustomer} from './userstranscation';

import {stripe } from './configuration';


/**
Attaches a payment source to a stripe customer account.

This code helps to creat strip customer id for an autheticated user.
*/
export const attachSource = async(uid: string, source: string) => {

    const customer = await  viewOrCreateCustomer(uid);
 //check if the user already as a customerid
    const existingSource =( customer as any).sources.data.filter((s:any) => s.id===source).pop();

    if (existingSource) {
        return existingSource;
    } 
    else {
        //create one if not found.
        await stripe.customers.createSource(customer.id, { source: source });
       
        return await stripe.customers.update(customer.id, { default_source: source });
    }
}




import * as functions from 'firebase-functions';
import {  stripe } from './configuration';
import { validateUID, checksAssert, catchErrors } from './errorhelper';
import { attachSource } from './sources';
import { getCustomer } from './userstranscation';

/**
Gets a user's charge history
*/
export const getUserCharges = async(uid: string, limit?: number) => {
    const customer = await getCustomer(uid);

    return await stripe.charges.list({ 
        limit, 
        customer 
    });
}

/**
Creates a charge for a specific amount
*/
export const createCharge = async(uid: string, source: string, amount: number, idempotency_key?: string) => {
    const customer = await getCustomer(uid);

    await attachSource(uid, source);
    
    return stripe.charges.create({
            amount,
            customer,
            source,
            currency: 'usd',
        }, 
        
        { idempotency_key }
     )
}


/////// DEPLOYABLE FUNCTIONS ////////

export const stripeCreateCharge = functions.https.onCall( async (data, context) => {
    const uid = validateUID(context);
    const source = checksAssert(data, 'source');
    const amount = checksAssert(data, 'amount');

    // Optional
    const idempotency_key = data.itempotency_key;

    return catchErrors( createCharge(uid, source, amount, idempotency_key) );
});


export const stripeGetCharges = functions.https.onCall( async (data, context) => {
    const uid = validateUID(context);
    return catchErrors( getUserCharges(uid) );
});

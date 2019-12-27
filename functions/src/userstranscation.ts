/**
 manage users transcations
 */


import {checksAssert} from './errorhelper';
import { db,stripe } from './configuration';



/**  Fetch users document from firestore */


export const getUser = async(uid:string)=>{

    return await db.collection('users').doc(uid).get().then(doc=>doc.data());

}
/**Get customer from stripe */
export const getCustomer = async(uid:string)=>{

    const user = await getUser(uid);

    return checksAssert(user,'stripeCustomerId')
}
/**Update user documents */

 export const updateUser = async(uid:string,data:Object)=>{

    return await db.collection('users').doc(uid).set(data,{merge:true}  );

 }
/**Create strip customer account with user firebase UID */

 export const createCustomer = async(uid:any)=>{
     const customer = await stripe.customers.create({
         metadata:{firebaseUID:uid}
     });

     await updateUser(uid,{stripeCustomerId:customer.id})

     return customer;
 }
/**Validate a customer */

 export const viewOrCreateCustomer = async(uid:any)=>{
     const user = await getUser(uid);
     const customerId = user && user.stripeCustomerId;

     if(!customerId){
         return createCustomer(uid);
     }
     else{
         return stripe.customers.retrieve(customerId);
     }
 }
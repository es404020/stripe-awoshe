

import * as functions from 'firebase-functions';
import { db } from './configuration';


/**
 
Get trigger when a users signups with google.It automatical added the users information to the cloud firestore database

*/

export const onGoogleSignUp = functions.auth.user().onCreate((user) => {
    const email = user.email; // The email of the user.
    const uid = user.uid;// The auth user ID

  return  db.doc(`users/${uid}`).set({
        email:email,
        uid:uid
    }).then((res)=>{}).catch((err)=>{
        console.log(err);
    })

  });




/**
 
Use callable functions to charge and also get charges from a authenticated user

*/

export {stripeCreateCharge ,stripeGetCharges} from './charge';
import * as functions from 'firebase-functions';
/**
Validates if the user is autheticated
*/
export const validateUID = (context: any) => {
    if (!context.auth) {
        throw new functions.https.HttpsError('permission-denied', 'function called without context.auth');
    } else {
        return context.auth.uid;
    }
}
/**

checks data payload exist .This also enable us view errors from our application.
*/
export const checksAssert = (data: any, key:string) => {
    if (!data[key]) {
        throw new functions.https.HttpsError('invalid-argument', `function missing  ${key} data`);
    } else {
        return data[key];
    }
}

/**
Handles other error that we ehere unable to catch like invalide card error from stripe api
*/
export const catchErrors = async (promise: Promise<any>) => {
    try {
        return await promise;
    } catch(err) {
        throw new functions.https.HttpsError('unknown', err)
    }
}
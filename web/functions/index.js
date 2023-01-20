const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp(functions.config().firebase);

exports.myScheduledCloudFunction = functions.pubsub.schedule('0 0 * * *').timeZone('Asia/Kuala_Lumpur').onRun(async (context) => {
   
    const querySnapshot = await admin.firestore().collection('users').get();
    querySnapshot.forEach(async (doc) => {
        const habitQuerySnapshot = await admin.firestore().collection('users').doc(doc.id).collection('habits').get();
        habitQuerySnapshot.forEach(async (habitDoc) => {
            // Check that the doc object exists and has a ref property
            if (doc && doc.ref) {
              // The doc object exists and has a ref property, so you can call update on it
              await habitDoc.ref.update({ 
                'iscompleted' : false,
                'completedcount': 0
                
              });
            }
        });
    });

    return null;
});

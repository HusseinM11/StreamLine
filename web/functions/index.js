const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp(functions.config().firebase);

//At every minute.
exports.myScheduledCloudFunction = functions.pubsub.schedule('00 00 * * *').timeZone('Asia/Kuala_Lumpur').onRun(async (context) => {
    //https://crontab.guru/

    // Get reference to document.
    // const habits = await admin.firestore().collection('users').get();


    // // Add 5 coins to the user.
    // cfDataDoc.ref.update({ 'coins': admin.firestore.FieldValue.increment(5) });

    // TODO: Update to a random name.


    admin.firestore().collection('users').get().then(function(querySnapshot) {
        querySnapshot.forEach(function(doc) {
            admin.firestore().collection('users').doc(doc.id).collection('habits').get().then(function(querySnapshot) {
                querySnapshot.forEach(function(habitDoc) {
                    admin.firestore().collection('users').doc(doc.id).collection('habits').doc(habitDoc.id).ref.update({ 
                        'iscompleted' : false,
                        'completedcount': 0
                    })
                })
            })
        })
    })

    return null;
});
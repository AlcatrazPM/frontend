self.addEventListener('activate', function(event) {
  console.log("installed");
});
async function sendd(event){
  clients.matchAll().then(cl => {
   let i=0;
   console.log(cl);
   for(i=0; i<cl.length; i++){
     cl[i].postMessage("Hello");
     }
   });
self.clients.claim();
 console.log("message");
  console.log(event);
  console.log(event.source.id);
  var client = await clients.get(event.source.id);
  console.log(client);
  client.postMessage({
                           msg: "Hey I just got a fetch from you!",
                           url: 'jnkjfnkjgbkjfgbkjf'
                         });



}
self.addEventListener('message', function(event){
  sendd(event);
});

fetch('/loggedUserId')
.then(response => response.json())
.then(data => {
  const loggedUserID = data.loggedUserID;
  console.log(loggedUserID);
  
})
.catch(error => console.error(error));


# End Points 
for local development port is 5000.
installation

```
git clone https://github.com/Arpit078/serverEcoTags.git

cd eco-tags
npm install
npm start
```

## userImages : GET https://eco-tags.onrender.com/userImages
returns an array of all the images posted by that user.

sample req - 
```
{
  "id":"3CjLMrsPnBfXisyO4ETHGopcVK32"
}
```

sample res - 
```
[
  "https://firebasestorage.googleapis.com/v0/b/ecotags.appspot.com/o/uploads%2FCAP267848995582434062.jpg?alt=media&token=ce102ca7-1114-4f56-85a1-6e148e983bc2",
  "https://firebasestorage.googleapis.com/v0/b/ecotags.appspot.com/o/uploads%2FCAP2739564765792456559.jpg?alt=media&token=06a6d9b3-b140-4776-b71f-33948f7273a1",
  "https://firebasestorage.googleapis.com/v0/b/ecotags.appspot.com/o/uploads%2FCAP4188053035781720625.jpg?alt=media&token=61e82f2c-d77c-493b-9407-42ce1c7340c2",
  "https://firebasestorage.googleapis.com/v0/b/ecotags.appspot.com/o/uploads%2FCAP987144691733675821.jpg?alt=media&token=adca167f-f46a-4802-868b-9e685ec7f8b6",
  "https://firebasestorage.googleapis.com/v0/b/ecotags.appspot.com/o/uploads%2FCAP7200582233160237706.jpg?alt=media&token=66bbd539-8062-4e1f-8ff9-951b9bbcf9a5",
  "https://firebasestorage.googleapis.com/v0/b/ecotags.appspot.com/o/uploads%2FCAP3558470058008303336.jpg?alt=media&token=6fcd078e-f65d-4105-a352-91a95838eec8",
  "https://firebasestorage.googleapis.com/v0/b/ecotags.appspot.com/o/uploads%2FCAP1169996662160443081.jpg?alt=media&token=d9165451-662c-488f-804f-68ea4fc106e9"
]
```


## addUser : POST https://eco-tags.onrender.com/addUser
user is stored with id as the username.
### A suggestion make a firebase call from frontend to send sms or email verification code then, when verified with the code using ui hit this endpoint so that we only write valid users.
### Sample request-
```
    {
    "emailPhone":8287206875,
    "username":"Arpit078",
    "password":"Test123",
    "first": "Arpit",
    "last": "Verma",
    "age": 19,
    "rank":"rookie"
    }
```

## login : POST https://eco-tags.onrender.com/login
the passwords are hashed in the database. So need to perform comparison with input password in login, following status codes are returned.

1. Authenticated -
- status code = 200
- response = "authenticated"

2. Not authenticated - 
- status code = 401
- response = "not authenticated"

3. can't perform hash comparison - 
- status code = 500
- response = "internal server error"

4. user does not exist - 
- status code = 404
- reponse = "user not found" 

### sample post req - 
```
{
  "username":"Arpit078",
  "password":"Test123"
}
```




## updateUser : PUT https://eco-tags.onrender.com/updateUser
hit this endpoint with username and rank to modify.
```
{
  "username":"Arpit078",
  "rank":"TopGun"//can change this to moderator rookie or whatever you like
}

```

## addImage : POST https://eco-tags.onrender.com/addImage
there is another collection in firestore to store images with longitudes and latitudes stored with usernames and rank. To calculate the verified locations.It has a field named verified so that can be used to display that pin differently on frontend or to perform computation and updating the points.
```
{
  "username":"arpit078",
  "url":"https://www.google.com/search?q=rick+roll&tbm=isch&source=iu&ictx=1&vet=1&fir=71qKiWaYspaw3M%252CXozf31seXIiHxM%252C_%253B8HdBXBEzeMHZ2M%252CBT3ERn4fLiaQQM%252C_%253BykWkrdwI5JNXcM%252C6s4NuhB18CEGIM%252C_%253Bie_LDBGF5NS2sM%252C13v8y9GqOjLBKM%252C_&usg=AI4_-kQjy11YNnzKUHSJP0V8vzT3K8PaSw&sa=X&ved=2ahUKEwjp1f375Pj8AhWlS3wKHWEJC9cQ_h16BAhUEAE#imgrc=8HdBXBEzeMHZ2M",
  "geotag_lat":"30.9686° N",
  "geotag_long":"76.4733° E",
  "verified":false
}

```

## getLocations : GET https://eco-tags.onrender.com/getLocations
this end point retreives the location of stored geotags to display on map.
### sample response - 
```
[
  {
    "longitude": "76.4733° E",
    "latitude": "30.9686° N",
    "verification status": "false",
    "posted by": "arpit078",
    "ranked": "rookie"
  },
  {
    "longitude": "76.4733° E",
    "latitude": "30.9686° N",
    "verification status": "false",
    "posted by": "Arpit078",
    "ranked": "rookie"
  }
]
```





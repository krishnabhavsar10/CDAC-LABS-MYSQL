// Mongo DB Assignments

//1.display all movies with rating=4
db.movies.find({rating:4})

//2.display all movies with rating=3 and price=200
db.movies.find({rating:3, price:200})

//3.display all movies with rating>3 and price=540 
db.movies.find({
   rating: {$gt: 3}, 
   price: 540
})

db.movies.find({
   $and: [
      {rating: {$gt: 3}}, 
      {price: 540}
   ]
})

//4.display all movies with rating>3 and price>300
db.movies.find({rating:{$gt:3}, price:{$gt:300}})

db.movies.find({
	$and:[
		{rating: {$gt: 3}},
		{price: {$gt:300}}
	]
})


//5.display all movies with price > 200 and < 400
db.movies.find({
   price: {
      $gt: 200,
      $lt: 400
   }
})


//6.display all movies with price = 200 or 540 400
db.movies.find({
  price: { $in: [200, 540, 400] }
})

//7.display all movies with price not = 200 nor 540  nor 400
/*
Difference Between $nin and $nor
$nin: It is used to exclude specific values from a field. It's typically used to filter out documents where a field's value is in a list of values.
Example: price: { $nin: [200, 400, 540] }
$nor: It is used to combine multiple conditions and return documents where none of the conditions are true.
Example: { $nor: [{ price: 200 }, { price: 400 }, { price: 540 }] }
So, you would use $nor if you need to combine multiple conditions and make sure none of them match, whereas $nin is better for excluding multiple values in a single condition.
*/
db.movies.find({price: { $nin: [200, 400, 540] } })

db.movies.find({
  $nor: [
    { price: 200 },
    { price: 400 },
    { price: 540 }
  ]
})


/* 
8.display count of  movies with price not = 200 nor 540  nor 400
sol: use count method as follows db.movie.find().count() 
*/
db.movies.find({price: {$nin: [200, 400, 540]}}).count()
/*
	Your query is almost correct, but the count() method is deprecated 
	in newer versions of MongoDB. 
	Instead, you can use the countDocuments() method for 
	counting the documents that match the query.
*/
db.movies.find({ price: { $nin: [200, 400, 540] } }).countDocuments()


//9.display all movies with rating=4 or price>300
db.movies.find({
	$or : [{rating : 4}, {price : {$gt : 300}}]
})

//10.display all movies with price not > 200 and < 400
db.movies.find({
  price: {
    $not: { $gt: 200 },
    $not: { $lt: 400 }
  }
})

//11.display all movies with rating is odd
db.movies.find({
  rating: { $mod: [2, 1] }
})

//12.display all movies in which amitabh has acted
db.movies.find({actors: "Amitabh"})

/* 
13.display all movies in which amitabh has acted display in 
   ascending order of price 
*/
db.movies.find({actors: "Amitabh"}).sort({price: 1})


// 14. Display all movies in which Amitabh has acted, display in descending order of price.
db.movies.find({actors: "Amitabh"}).sort({price: -1})  

// 15. Display all movies in which Amitabh has acted, display only the 1st document.
db.movies.find({actors: "Amitabh"}).limit(1)  

// 16. Display all movies in which Amitabh has acted, display only the 1st 5 documents.
db.movies.find({actors: "Amitabh"}).limit(5)  

// 17. Display top 5 highest-rated movies.
db.movies.find().sort({rating: -1}).limit(5)  

// 18. Display lowest 3 rating movies.
db.movies.find().sort({rating: 1}).limit(3) 

// 19. For movie "Kahani 2", change rating to 5.
db.movies.updateOne({name: "Kahani 2"}, {$set: {rating: 5}})  

// 20. Change price to 400 and increase rating by 2 for all movies with name Kahani in it.
db.movies.updateMany({name: /Kahani/}, {$set: {price: 400}, $inc: {rating: 2}})  

// 21. Decrease price of all movies by Rs. 40.
db.movies.updateMany({}, {$inc: {price: -40}})  

// 22. Increase the price by 10% of price.
db.movies.updateMany({}, [
  {$set: {price: {$multiply: ["$price", 1.1]}}}
])  

// 23. Display all movies with Amitabh and at 1st index position in the array.
db.movieCollection.find({ actors: /^[Aa]mitabh/ })

// 24. Find all movies starting with a digit.
db.movies.find({name: /^[0-9]/})  // Ideal approach using regex

// 25. Find all movies with name starting with a digit and ending with 's'.
db.movies.find({name: /^[0-9].*s$/})  

// 26. Find all movies with name starting with alphabet.
db.movies.find({name: /^[A-Za-z]/})  

// 27. Change rating of movie "Kesari" to 2.
db.movies.updateOne({name: "Kesari"}, {$set: {rating: 2}})  

// 28. Increase the price of all tickets by Rs. 20 for Amitabh's movie.
db.movies.updateMany({actors: "Amitabh"}, {$inc: {price: 20}})  

// 29. Delete key "rating" for movie "Kesari".
db.movies.updateOne({name: "Kesari"}, {$unset: {rating: ""}})  

// 30. Increase price by 50 and change rating to 7 for movie "3 Idiots".
db.movies.updateOne(
	{name: "3 Idiots"}, 
	{
		$set: {rating: 7}, 
		$inc: {price: 50}
	}
)  

// 31. Delete the first value from the array (e.g., remove first actor).
db.movies.updateOne({}, {$pop: {actors: -1}})  

// 32. Change price to 400 and increase rating by 2 for all movies with the name Kahani in it.
db.movies.updateMany({name: /Kahani/}, {$set: {price: 400}, $inc: {rating: 2}})  
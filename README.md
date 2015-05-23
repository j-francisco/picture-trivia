# picture-trivia
Experimental trivia app that can run on iOS via [Cordova](https://cordova.apache.org/)

The app is built with Cordova, Backbone.js and CoffeeScript. 

The backend is a Ruby on Rails app for storing and retrieving the game questions, answers, users and game history. There's not much authentication though.

I used [ratchet](http://goratchet.com/) for some of the styling.

All of the app CoffeeScript code is in **www/js/src** and is automatically compiled into javascript in **www/js/bin** with **cake**. Then I use [r.js](https://github.com/jrburke/r.js/) and [almond](https://github.com/jrburke/almond) to use RequireJS-like syntax for loading modules and compiling everything into a single javascript file (**www/js/bin/main_app.js**)

The fun part was combining all these different things and getting it all to work. Realistically, the game isn't very impressive. There's just three easy questions and then a fake final score screen. I stopped working on it to focus on other projects. But it's a good example of how to use the various libraries and frameworks together.

#### To setup (on a Mac):

* Install Node.js

* Follow this [tutorial](http://ccoenraets.github.io/cordova-tutorial/create-cordova-project.html) to install cordova, the ios platform, the ios emulator and the other basic cordova plugins it talks about.

* Create a postgres database named **picture_trivia_dev**

* Run the rails backend api from the **picture_trivia_api** directory:
> foreman start

  You'll need to create a new user record in the database from the rails console.
  
  You can create more questions by going to **http://localhost:5000/questions/new**, but the pictures get uploaded to Cloudinary, so you'll need to add your own cloudinary.yml to the **www/picture_trivia_api/config** directory.

* Enable automatic CoffeeScript compilation from the **www** directory:
> cake watch

  With this running, every time you save a .coffee file in **www/js/src**, it gets compiled into a .js file in **www/js/bin** 

* After you make changes, re-build from the **www** directory with:
> node r.js -o app.build.js

  This uses the config in **app.build.js** to compile all of the required .js files and libraries into a single file named **main_app.js**, which is loaded in **index.html**.

* Run in the ios emulator:
> cordova emulate ios

* Or just run in a browser by launching a python server from the **www** directory:
  
  `python -m SimpleHTTPServer`

  Then go to **http://localhost:8000**

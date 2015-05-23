# picture-trivia
Experimental trivia app in backbone/coffeescript/rails that can run on iOS via Cordova

The app is built with cordova, backbone.js and coffeescript. The backend is ruby on rails for storing the game questions, answers, users and game history. All of the app coffeescript code is in **www/js/src** and is automatically compiled into javascript in **www/js/bin** with **cake**. Then I use [r.js](https://github.com/jrburke/r.js/) and [almond](https://github.com/jrburke/almond) to use RequireJS-like syntax for loading modules and compiling everything into a single javascript file (**www/js/bin/main_app.js**)

#### To setup (on a Mac):

* Install Node.js

* Follow this [tutorial](http://ccoenraets.github.io/cordova-tutorial/create-cordova-project.html) to install cordova, the ios platform, the ios emulator and the other basic cordova plugins it talks about.

* Run the app from the **www** directory:
> python -m SimpleHTTPServer

* Create a postgres database named **picture_trivia_dev**

* Run the rails backend api from the **picture_trivia_api** directory:
> foreman start

  You'll need to create a new user record in the database from the rails console.

* Enable automatic coffeescript compilation from the **www** directory:
> cake watch

* After you make changes, re-build from the **www* directory with:
> node r.js -o app.build.js

* Run in the ios emulator:
> cordova emulate ios

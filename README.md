# picture-trivia
Experimental trivia app in backbone/coffeescript/rails that can run on iOS via Cordova

# To setup (on a Mac):

* Install Node.js

* Follow this [tutorial](http://ccoenraets.github.io/cordova-tutorial/create-cordova-project.html) to install cordova, the ios platform, the ios emulator and the other basic cordova plugins it talks about.

* Run the app from the **www** directory:
> python -m SimpleHTTPServer

* Run the rails backend api from the **picture_trivia_api** directory:
> foreman start

* Enable automatic coffeescript compilation from the **www** directory:
> cake watch

* After you make changes, re-build from the **www* directory with:
> node r.js -o app.build.js

* Run in the ios emulator:
> cordova emulate ios

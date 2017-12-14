# GO-JEK FOR DRIVER

rails new gojek-for-driver -T -d postgresql

bundle install

rails generate rspec:install

rails g model User

rails g model Type name:string base_fare:float

rails g migration add_type_to_orders reference:type

rails db:create

rails db:migrate

rails db:seed

rails g controller Users

http://almsaeedstudio.com/download/AdminLTE-dist
https://adminlte.io/themes/AdminLTE/index2.html

cp ~/Downloads/AdminLTE-2.3.11/dist/css/AdminLTE.css app/assets/stylesheets/
mkdir app/assets/stylesheets/skins
cp ~/Downloads/AdminLTE-2.3.11/dist/css/skins/skin-black-light.css app/assets/stylesheets/skins

assets/stylesheets/application.css
```
/*
 *
 *= require style
 *= require_self
*/
```


new style.scss
```
@import "bootstrap-sprockets";
@import "bootstrap";

@import "AdminLTE";
@import "skins/skin-black-light";
```

edit #app/views/layouts/application.erb

cp ~/Downloads/AdminLTE-2.3.11/dist/js/app.js app/assets/javascripts/
mkdir vendor/assets
mkdir vendor/assets/javascripts
cp ~/Downloads/AdminLTE-2.3.11/plugins/slimScroll/jquery.slimscroll.min.js vendor/assets/javascripts/

application.js
```
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require jquery.slimscroll.min
//= require_tree .
```

view/navigation

don't use
# gem 'bootstrap', '~> 4.0.0.beta2.1'

use
gem 'bootstrap-sass', '~> 3.2.0'

bundle install
rails s
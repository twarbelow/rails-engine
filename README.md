# Rails Engine

JSON API complicant Ruby on Rails ReST API that exposes data for an e-commerce business.

[Project Requirements](https://backend.turing.edu/module3/projects/rails_engine/requirements)

### Setup and Installation
From the Command Line, after cloning this repo:
1. `cd rails_engine` to go into the rails_engine directory
1. Run `bundle install` to install dependencies
1. Run `bundle exec rake data:import` to create database and import data (Note: You will see a warning when running this command that data may be deleted. This is fine unless you've already added data to the database)
1. You should now be able to run `bundle exec rspec` to see 58 passing tests
1. Run `rails s` to start up the Rails Server

You should now be able to visit any of the endpoints below by prefacing them with localhost:3000 to see the raw JSON response, or by using a client like Postman.

POST /api/v1/items
Accept JSON body:
​{“name”: “value1”, “description”: “value2”, “unit_price”: 100.99, “merchant_id”: 14}
Return JSON response for the created item
​{ “data”: { “id”: “16”, “type”: “item”, “attributes”: { “name”: “Widget”, “description”: “High quality widget”, “unit_price”: 100.99, “merchant_id”: 14}}}

DELETE /api/v1/items/:id
return 204 HTTP, no JSON body

PATCH /api/v1/items/:id
Accept JSON body:
​{ “name”: “value1”, “description”: “value2”, “unit_price”: 100.99, “merchant_id”: 7}
​​return JSON response for updated item
{ “data”: { “id”: “16”, “type”: “item”,  attributes”: { “name”: “New Widget”, “description”: “High quality widget”, “unit_price”: 200.99, “merchant_id”: 17}}}

GET /api/v1/merchants/:id
Return JSON of corresponding record, if found
{ “data”: { “id”: “1”, “type”: “merchant”, “attributes”: { “name”: “Merchant Name”}}}

GET /api/v1/items/:id
Return JSON of corresponding record, if found
{ “data”: { “id”: “16”, “type”: “item”,  attributes”: { “name”: “New Widget”, “description”: “High quality widget”, “unit_price”: 200.99}}}


EITHER name param, OR one or both min_price and max_price (which will be intrepreted as equal to or greater/less than
GET /api/v1/items/find?name=ring
GET /api/v1/items/find?max_price=50
GET /api/v1/items/find?min_price=50
GET /api/v1/items/find?max_price=100&min_price=50

Return JSON of corresponding record, if found
{ “data”: { “id”: “16”, “type”: “item”,  attributes”: { “name”: “New Widget”, “description”: “High quality widget”, “unit_price”: 200.99}}}

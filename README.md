### Testing the Plugin

You need to have Docker and pongo installed for this to work.

Follow these steps to test the `http-cat` plugin locally using [Kong Pongo](https://github.com/Kong/kong-pongo):

#### 1. Start the Kong Environment with Pongo
Run the following command to spin up a local Kong testing environment:
```
pongo up
```

#### 2. Access the Pongo Shell

Enter the Pongo shell to interact with the Kong container:
```
pongo shell
```

#### 3. Start Kong Manager Shell (KMS)

In the Pongo shell, start the Kong Manager Shell to manage Kong:

```
kms
```

#### 4. Verify Plugin Installation

Ensure the http-cat plugin is available on the server:

```
curl -s localhost:8001 | \
  jq '.plugins.available_on_server."http-cat"'
```
You should see true if the plugin is correctly installed.

#### 5. Create a Service

Create a test service pointing to httpbin:

```
curl -i -s -X POST http://localhost:8001/services \
   --data name=example_service \
   --data url='https://httpbin.konghq.com'
```

#### 6. Enable the Plugin on the Service

Attach the http-cat plugin to the created service:

```
curl -is -X POST http://localhost:8001/services/example_service/plugins \
   --data 'name=http-cat'
```
#### 7. Create a Route

Add a route for the service to test plugin behavior:
```
curl -i -X POST http://localhost:8001/services/example_service/routes \
   --data 'paths[]=/mock' \
   --data name=example_route
```

#### 8. Test the Plugin

Send a request to the mock route to see the plugin in action:
```
curl -i http://localhost:8000/mock/status/200
```
You should receive a response with the corresponding HTTP Cat image for the 200 status code.  You should try this with other http codes such as 201, 202, 300, 400, 404 etc

#### 9. Exit the Pongo Shell

When done, exit the Pongo shell:

```
exit
```

#### 10. Tear Down the Environment

Shut down the Pongo environment:

```
pongo down
```


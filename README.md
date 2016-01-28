# swift-webframeworks-docker
A Docker container used for spinning up different Swift web frameworks

## Why
 - Very few commands to spin up a development container
  - Great for getting other team members setup
 - Don't need to install framework dependencies on your host OS
  - ex: `Epoch` needs `libvenice`, `http-parser`, and `uri-parser`
 - Because you don't have to spend 8 hours doing this same thing that I had to do :innocent:

## Which frameworks are included
- [x] [Swiftra](https://github.com/takebayashi/swiftra)
- [x] [Epoch](https://github.com/Zewo/Epoch)
- [ ] [Vapor](https://github.com/tannernelson/vapor)

## How to use
1. Clone/fork repo
2. Run Swifta
  1. `cd swiftra`
  2. `docker-compose build`
  3. `docker-compose up`
    - This rebuilds the project (by using `swift build`) and then runs the build 
    - Rerun this command after making changes to the project 
  4. Hit machine url on port 8080
    - ex: http://192.168.99.100:8080
3. Run Epoch
  1. `cd epoch`
  2. `docker-compose build`
  3. `docker-compose up`
    - This rebuilds the project (by using `swift build`) and then runs the build 
    - Rerun this command after making changes to the project 
  4. Hit machine url on port 8080
    - ex: http://192.168.99.100:8080

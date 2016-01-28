# swift-webframeworks-docker
A Docker container used for spinning up different Swift web frameworks

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
  4. Hit machine url on port 8080
    - ex: http://192.168.99.100:8080
3. Run Epoch
  1. `cd epoch`
  2. `docker-compose build`
  3. `docker-compose up`
  4. Hit machine url on port 8080
    - ex: http://192.168.99.100:8080

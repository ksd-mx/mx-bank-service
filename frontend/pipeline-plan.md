# branch names
- feat/* : feature branches for tickets and ad-hoc implementations
- fix/* : hotfixes and maintenance for bug tickets and refactoring
- main : development environment
- test : staging environment
- live : production environment

# integrations

# build stages - backend
- validate : linting step for python + cloudformation validation
- build : build step for all lambdas
- test : run lambda functions unit tests

# deployment
- feat/* + fix/* : branch specific stack | self destructs after 24hs
* 
- main : continuouly integrated development environment for team tests
- test : exclusive to staging account pipeline
- live : exclusive to production environment pipeline
# CLIn Boards

> Before starting!
>
> 1. Create a new folder with the project name and open it from VS Code
>
> 2. From the VS Code terminal run the next docker command
>
> ```powershell
> docker container run \
> --name ruby \
> -it \
> -v $(pwd):/app \
> -v ssh:/root/.ssh \
> -v bundle:/usr/local/bundle \
> -e GIT_USER_NAME=<your_username> \
> -e GIT_USER_EMAIL=<your_email> \
> --rm \
> codeableorg/ruby
> ```
>
> 3. Clone the repository of your work team
>
> ```powershell
> $ git clone git@github.com:codeableorg/calencli-c4w1-xxx.git .
> ```
>
> 4.  Run some initialization scripts
>
> ```powershell
> $ bootstrap
> ```
>
> 5.  Install some necessary gems for rubocop to work properly
>
> ```powershell
> $ bundle install
> ```
>
> ready, you can work on your project!

Looking for the project instructions? Find them on [this notion doc](https://www.notion.so/ableco/Pokemon-Ruby-8d96d56eefe74bd982450b9513151a50)

To disable temporarily any Rubocop convention:

```
# rubocop:disable Metrics/AbcSize
def complex_and_irreducible_method(that, receive, a, lot, of, params)
  ...
  ...
  ...
end
# rubocop:enable Metrics/AbcSize
```

To disable them, use the convention that Rubocop is complaining about. _Metrics/AbcSize_ is just an example.

Find the instructions [here](https://school.codeable.la/app/weeks/5/lessons/db2261426cd544c68ea3034355035f25)

#jukeBox
jukeBox allows registered users to play songs off of an admin's pre-approved playlist. Admins can add and delete songs.

The project is for [Epicodus](http://www.epicodus.com/).

##Setup
In your terminal, clone this repo:

```console
$ git clone https://github.com/moofmayeda/jukebox.git
```

Make sure you've installed [postgres](http://www.postgresql.org/download/) and have started the server:

```console
$ postgres
```

Install all the dependencies:

```console
$ bundle install
```

Set up the databases on your local machine:

```console
$ rake db:create
$ rake db:migrate
```

Finally, start the rails server:

```console
$ rails s
```
It should now be available at `localhost:3000`.

##Author
[moof mayeda](https://github.com/moofmayeda)

##License
MIT

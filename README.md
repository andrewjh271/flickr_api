# Flickr API

Created as part of the Odin Project [curriculum](https://www.theodinproject.com/courses/ruby-on-rails/lessons/using-an-api). View [live page](https://infinite-reef-28711.herokuapp.com/).

### Functionality

Search Flickr by User ID or Tags. If no results are found a suggested search is provided.

### Thoughts

I used the [flickr](https://github.com/cyclotron3k/flickr) gem API kit, as it seemed to be the slightly more recently maintained version of the most popular `FlickRaw`. There is not much documentation for it, and one challenge was figuring out what I could do with the `Flickr::ResponseList` object that was returned after requesting data from the Flickr API. Calling `#methods` on the returned object gave me the most helpful information I could find.

The [figaro](https://github.com/laserlemon/figaro) gem generated a `config/application.yml` file where I could configure `ENV['FLICKR_API_KEY']` and `ENV['FLICKR_SHARED_SECRET']`.

Some useful arguments for `flickr.photos.search` from the Flickr API documentation were `tags`, `tag_mode`, `sort`, `page`, `extras`, and `per_page`. I used `flickr.interestingness.getList` to help generate random search suggestions for either User ID or Tags after an unsuccessful search.
# Presentation: Reveal.js

For those of you who know me, you know that I'm a huge fan of Reveal.js. I try to run my presenations from a container whenever possible, and Reveal.js allows me to do this really well. You have a couple of options for viewing this presentation.

1. Review the Markdown file located in ./show/slides/{{presentation}}.md
2. If you want all the pretty colors, pictures and other content then you can choose to run the presentation in a container.

## The "Pretty" Version

First, clone this repo:

```
git clone https://you-know-what-link-to.git
```

Next, run the container:

```
docker run -d \
-p 8001:8000 \
-v /PATH/TO/FOLDER/CONTAINING/show:/show \
rguillom/reveal
```

And that's it...enjoy!

-v1k0d3n

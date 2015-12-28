---
layout: post
title: "SDL Setup"
---

So let's start with a quick explanation. I've done some research, and I've
decided I need to commit to some larger project. I picked out my language, C.
The reasons for this are simple: I like low-level, and I was hoping for more
control over what I'm doing. Then I decided on a library. I needed something
cross-platform; that narrowed down my decisions. I also wanted to develop a lot
of the logic myself. You know, as an exercise. After a short trip to Google,
[SDL2](http://www.libsdl.org/) turned out to be the best choice (mobile support
too!).

So that's where I was about a week ago. After a lot of Googling, I've been
using inspiration from [Handmade Hero](https://handmadehero.org/) as to how I
should go about structuring, with my own personal touches.

# Initializing

So this was a quick thing to figure out, and I ended up making it it's own
function. The process for initializing an SDL2 window is simple, really.

{% highlight c %}
SDL_Init(SDL_INIT_VIDEO)
{% endhighlight %}

According to the documentation, this returns `0` when successful, or some other
value when failed. running that check we get

{% highlight c %}
if (SDL_Init(SDL_INIT_VIDEO) != 0) {
    // do stuff
}
else {
    printf("error: %s\n", SDL_GetError());
    return -1;
}
{% endhighlight %}

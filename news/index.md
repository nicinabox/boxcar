---
layout: news
title: News
author: all
---

{% for post in site.posts %}
  {% include post/micro.html %}
{% endfor %}

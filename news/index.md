---
layout: news
title: News
author: all
---

{% for post in site.posts %}
  {% include news_item.html %}
{% endfor %}

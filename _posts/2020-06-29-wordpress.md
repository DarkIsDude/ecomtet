---
layout: post
title: "Wordpress, really"
date: 2020-05-29 21:31:53 +0000
categories: [blog]
tags: [blog,wordpress,hosco,migration,cms]
---
---
We released a new advice section (the official Hosco blog) on hosco.com one month ago. This section have the new look and feel, a translation system, a search engine, a comment system... thanks to Wordpress. Yeah, wordpress, in a team with 12 developers. But keep on reading, you might even adopt it too!

## Why

Hosco has an advice section since the beginning.

```text
Here at Hosco, it’s our mission to empower hospitality, not only through incredible job opportunities but also by providing you with inspirational career nutrition.

https://www.hosco.com/advice/en/hospitality-influencers-season-2/
```

Hosco needs to provide content to our users to help them grow in the hospitality market, for that we have a content team. The process for publishing an article on our old platform was not efficient:

- Write a Word document
- Create a JIRA
- The tech team can now transform the Word document in HTML
- Inject the new article in the website
- Deploy in production

The idea was to create for the content team a new space where they could easily create and publish content autonomously and independently from the tech team. The main advantages of the new process are:

- More autonomy
- Decoupling
- Less friction
- No maintenance from tech team
- No coding needed
- Reduce cost

And then, we chose Wordpress. I was the first against that... Hey, I'm a developer! But wordpress is really great because thanks to it, you can maximize all objectives mentioned above. In the following table you'll be able to compare Wordpress with other similar CMS's:

|                                | Ghost | Wordpress                                      | Drupal | Homemade |
| ------------------------------ |:-----:| ----------------------------------------------:|-------:| --------:|
| Maintenance                    | Quick | Quick                                          | Medium | Hard     |
| Multilang. (on 1 profile)      | ?     | TRUE                                           | TRUE   | Hard     |
| URLs per Lang & Categ          | FALSE | TRUE                                           | TRUE   | TRUE     |
| Scheduling                     | TRUE  | TRUE                                           | TRUE   | FALSE    |
| Drafting                       | TRUE  | TRUE                                           | TRUE   | FALSE    |
| Photos                         | TRUE  | TRUE                                           | TRUE   | TRUE     |
| Videos                         | TRUE  | TRUE                                           | TRUE   | TRUE     |
| Videos from youtube            | TRUE  | TRUE                                           | TRUE   | TRUE     |
| Videos from vimeo              | TRUE  | TRUE                                           | TRUE   | TRUE     |
| Twitter card generator         | TRUE  | Plugin                                         | Plugin | TRUE     |
| FB card generator              | TRUE  | Plugin                                         | Plugin | TRUE     |
| Friendly text editor interface | TRUE  | Divi theme (more powerful editing system)      | Complex| Hard     |
| Custom features via plugins    | FALSE | TRUE                                           | TRUE   | FALSE    |
| search content                 | FALSE | TRUE                                           | TRUE   | Hard     |
| Page speedy                    | TRUE  | Ghost to be up to 1,900% faster than WordPress | FALSE  | TRUE     |
| Security                       | TRUE  | Wordpress has a lot of vulnerabilities         | 50/50  | TRUE     |
| Price                          | 200$  | 25€ (wordpress.com) or FREE                    | -      | FREE     |

Then, let's go with Wordpress 😅

## When

With the lockdown and the difficult time, Hosco needed to provide more and more content to our industry... The content team needed to act fast, to provide graphs, surveys, links, PDF's, among other formats. So it looked like the right time to get it done ! NOW !

## How

Our main concern (from a tech point of view) was the security. We created a new VPC (Private Network) in our AWS infrastructure. Thanks to that, even if someone compromises wordpress, the attacker would have access to only this network... with only wordpress in it.

Then, it was time to start thinking about the design. A standard Wordpress design ? It really looked too "teenage-like" for our Product Owner and Designer... Maria Jose suggested `Divi theme`. She had used it in the past and  had a really good feedback. To be honest, it was our best choice. Thanks to that, our Product Owner was able to design mostly alone the website without the tech team, and now the content team can create new articles with exactly what they want (graphics, columns, videos, search, ...). The website is pretty slow from an SEO point of view but the benefits are huge from an administrator perspective.

We also use some other plugins.

- [UpdraftPlus](https://wordpress.org/plugins/updraftplus/) Backups and restores to/from S3 our wordpress.
- [Yoast SEO](https://yoast.com/wordpress/plugins/seo/) Handles the technical optimization of our site (XML sitemap, robots.txt) & assists with optimizing the content: SEO/social Meta-tags (Title, description, og. images, canonical, hreflang, etc..).
- [Polylang](https://wordpress.org/plugins/polylang/) Adds multilingual capability to WordPress (also language switcher in the menu/footer): This is essential to manage our international websites: multilanguage posts, categories, menu, etc…
- [Duplicate Page](https://wordpress.org/plugins/duplicate-page/) Help the content team to translate an article: with the Polylang plugin, you need to create a new article for each language, so you end up recreating the design every time. Thanks to this plugin, the content team can duplicate the original article and translate the content without worrying again about the design.
- [Social Media](https://www.elegantthemes.com/plugins/monarch/)
- [Google Tag Manager](https://wordpress.org/plugins/duracelltomi-google-tag-manager/) Manages and deploys analytics and marketing tags.
- [Wordfence Security](https://www.wordfence.com/) Improves security website.

## And now

We are still working on the performance of the website. We have some wordpress skills in the team and we are trying out some plugins. We'll also try to use Cognito to manage the login of our users on the website.

But right now we are working with the mobile team. We want to display our advice section on our iOS and Android apps. They are connected through the API, but due to the standard installation, you can't filter articles by languages or categories. So we created a very small plugin for wordpress (`./wp-content/plugins/hosco-plugin/plugin.php`).

```php
<?php
/**
 * Plugin Name: Hosco Plugin
 * Description: Add some filters in the wordpress API
 * Author: Dev Hosco
 * Author URI: https://wwww.hosco.com
 * Version: 0.1
 * License: GPL2+.
 **/
add_filter('register_taxonomy_args', 'my_taxonomy_args', 10, 2);

function my_taxonomy_args($args, $taxonomy_name)
{
    if ('language' === $taxonomy_name) {
        $args['show_in_rest'] = true;
        $args['rest_base'] = 'language';
        $args['rest_controller_class'] = 'WP_REST_Terms_Controller';
    }

    if ('category ' === $taxonomy_name) {
        $args['show_in_rest'] = true;
        $args['rest_base'] = 'category';
        $args['rest_controller_class'] = 'WP_REST_Terms_Controller';
    }

    return $args;
}

```

You can now use the wordpress api to filter by language (`?language=1`) or categories (`?category=1`). The languages list is available behind `/wp-json/wp/v2/language`.

Finally, wordpress is a good choice if you want a lot of flexibility and to build a website quickly. Thanks to the Divi theme, you can do more or less exactly what you want. Your users can publish articles in many languages. Wordpress is free but if you want a professional look and feel, you'll need to invest for some extra customization (Divi plugin, security plugin and cache plugin in our case).

Have you ever work with Wordpress, or are you considering it now? Let us know in the comments below! And don't forget to take a look at the final result on hosco.com/advice

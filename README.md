# `elm-land` accessible navigation example

Implementing the advice from this article https://www.gatsbyjs.com/blog/2019-07-11-user-testing-accessible-client-routing/

Namely:

> - Provide a skip link that takes focus on a route change within the site, with a label that indicates what the link will do when activated: e.g. "skip to main navigation".
> - Include an ARIA Live Region on page load. On a route change, append text to it indicating the current page, e.g. "Portfolio page".

The skip link and live region are in `Layouts.Sidebar`.

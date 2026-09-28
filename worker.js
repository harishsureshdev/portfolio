// www.harishsuresh.dev -> harishsuresh.dev (301, path and query kept);
// everything else is the static site in dist/.
export default {
  async fetch(request, env) {
    const url = new URL(request.url);
    if (url.hostname === "www.harishsuresh.dev") {
      url.hostname = "harishsuresh.dev";
      return Response.redirect(url.toString(), 301);
    }
    return env.ASSETS.fetch(request);
  },
};

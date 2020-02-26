# getBranchUrl

## This shell script will allow onBranders to quickly access the full git branch URL to access their branch staging.

---

### Quick Set Up

1. Copy this file into your home directory
   a) In terminal: cd ~
   b) To copy, open the current folder in finder,
   In Terminal: open `pwd`
   c) Copy and pasta in there

2. Open your .bash_profile
   a) From anywhere in terminal,
   In Terminal: code ~/.bash_profile

3. Copy paste this in the last line

   source ~/get_branch_url.sh

   (this will allow you to run this file in all new terminals)

4. Restart your terminal and voila!

To change name of function call, simply change the
function name below where indicated. Then restart your terminal.

---

### Additional Information

This script will require the folder in which this is called to have a **dev-options.js** file.

The following use cases have been tested:

1. fullHubUrl has the full URL:

```javascript
fullHubUrl: "https://onbrand.uberflip.com/" ...
```

2. fullHubUrl references an object:

```javascript
  const hubs = {
    en: 'onbrand.uberflip.com/',
  };

  fullHubUrl: `https://${hubs.en}`  ...

```

Please let me know if there's any issues with grabbing the correct URL.

  import { PageFlip } from "page-flip";


  const pageFlip = new PageFlip(document.getElementById('book'), {
    width: 400,
    height: 600,
  });

  pageFlip.loadFromHTML(document.querySelectorAll('.post'));

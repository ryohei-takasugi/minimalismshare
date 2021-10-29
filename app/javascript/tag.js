if (location.pathname.match("experiences/new")){
  document.addEventListener("DOMContentLoaded", tagSearchMain);
};

function tagSearchMain() {
  const inputElement = document.getElementById("experience_tag_name");
  inputElement.addEventListener("keyup", () => {
    const keyword = document.getElementById("experience_tag_name").value;
    const XHR     = new XMLHttpRequest();
    XHR.open("GET", `search/?keyword=${keyword}`, true);
    XHR.responseType = "json";
    XHR.send();
    XHR.onload = () => {
      tagSearchResult(XHR.response);
    }
  });
}

function tagSearchResult(response) {
  const searchResultUl = document.getElementById("search-result");
  if (response) {
    const tagName    = response.keyword;
    const spanEnable = editCssResultSpanVisibility(tagName, searchResultUl);
    searchResultUl.innerHTML = "";
    if (spanEnable === true) {
      addHtmlSearchResult(tagName, searchResultUl);
    }
  } else {
    editCssResultSpanVisibility('', searchResultUl);
  }
}

function editCssResultSpanVisibility(tagName, searchResultUl) {
  if (tagName.length !== 0) {
    searchResultUl.style.visibility = "visible";
    return true
  } else {
    searchResultUl.style.visibility = "hidden";
    return false
  }
}

function addHtmlSearchResult(tagName, searchResultUl) {
  tagName.forEach((tag) => {
    const childElement = document.createElement("li");
    childElement.setAttribute("class", "child");
    childElement.setAttribute("id", tag.id);
    childElement.innerHTML = tag.name;
    searchResultUl.appendChild(childElement);
    const clickElement = document.getElementById(tag.id);
    clickElement.addEventListener("click", () => {
      document.getElementById("experience_tag_name").value = clickElement.textContent;
      clickElement.remove();
      editCssResultSpanVisibility('', searchResultUl);
    });
  });
}



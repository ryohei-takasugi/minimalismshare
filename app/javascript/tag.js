if (location.pathname.match("experiences/new")){
  document.addEventListener("DOMContentLoaded", tagKeyUpEvent);
};


function tagKeyUpEvent() {
  const inputElement = document.getElementById("experience_tag_name");
  inputElement.addEventListener("keyup", tagSendServer);
}

function tagSendServer() {
  const keywords = document.getElementById("experience_tag_name").value.split(',');
  const keyword  = keywords[keywords.length - 1].replace(/\s+/g, "");
  const xhr      = new XMLHttpRequest();
  xhr.open("GET", `search_tag/?keyword=${keyword}`, true);
  xhr.responseType = "json";
  xhr.send();
  xhr.onload = () => {
    tagSearchResult(xhr.response);
  }
}

function tagSearchResult(response) {
  const resultViewUl = document.getElementById("search-result");
  if (response) {
    const tags       = response.keyword;
    const spanEnable = editCssResultUlVisibility(tags);
    resultViewUl.innerHTML = "";
    if (spanEnable) {
      addHtmlSearchResult(tags);
    }
  } else {
    editCssResultUlVisibility('');
  }
}

function editCssResultUlVisibility(tags) {
  const resultViewUl = document.getElementById("search-result");
  if (tags.length !== 0) {
    resultViewUl.style.visibility = "visible";
    return true
  } else {
    resultViewUl.style.visibility = "hidden";
    return false
  }
}

function addHtmlSearchResult(tags) {
  tags.forEach((tag) => {
    const childElement = document.createElement("li");
    childElement.setAttribute("class", "child");
    childElement.setAttribute("id", tag.id);
    childElement.innerHTML = tag.name;
    document.getElementById("search-result").appendChild(childElement);
    const clickElement = document.getElementById(tag.id);
    clickElement.addEventListener("click", () => {
      const inputElement = document.getElementById("experience_tag_name")
      const keywords = inputElement.value.split(',')
      if (keywords.length >= 2) {
        keywords.splice(keywords.length - 1, 1)
        inputElement.value = keywords.join(',') + ',' + clickElement.textContent;  
      } else {
        inputElement.value = clickElement.textContent
      }
      clickElement.remove();
      editCssResultUlVisibility('');
    });
  });
}



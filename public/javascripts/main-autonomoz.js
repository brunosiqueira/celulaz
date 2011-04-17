function change_tab(id){
    close_tab("tab1");
    close_tab("tab2");
    close_tab("tab3");
    document.getElementById("conteudo_icon").style.display = "block";
    document.getElementById(id).style.display = "block";
    document.getElementById(id+"-link").className = "select";
}

function close_tab(id){
    document.getElementById("conteudo_icon").style.display = "none";
    document.getElementById(id+"-link").className = "unselected";
    document.getElementById(id).style.display = "none";
}
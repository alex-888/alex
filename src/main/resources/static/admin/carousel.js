/**
 * 修改首页轮播图
 * @type {Element}
 */
const carouselTable = document.querySelector('#carouselTable');
const creater = carouselTable.querySelector('tr');

function addSpec() {
    let newEle = creater.cloneNode(true);
    let nodes = newEle.querySelectorAll('td');
    nodes[nodes.length - 1].innerHTML = `
<a href="javascript:;" onclick="moveUp(this)">
    <i class="fa fa-arrow-up fa-lg"></i></a>
    <a href="javascript:;" onclick="this.parentElement.parentElement.remove()" class="remove">
    <i class="fa fa-remove fa-lg"></i></a>
    <a href="javascript:;" onclick="moveDown(this)">
    <i class="fa fa-arrow-down fa-lg"></i></a>
    `;
    carouselTable.insertBefore(newEle, creater);
    creater.querySelectorAll('input').forEach(input => input.value = '');
    creater.querySelectorAll('img.carousel').forEach(img => img.remove());
};
function moveDown(ele) {
    let tr = ele.parentElement.parentElement;
    let tr1 = tr.nextElementSibling;
    if(tr1.nodeName.toLocaleLowerCase() !== 'tr' || tr1.querySelectorAll('#new').length > 0) {
        return;
    }
    carouselTable.insertBefore(tr1, tr);
}
function moveUp(ele) {
    let tr = ele.parentElement.parentElement;
    let tr1 = tr.previousSibling;
    if(tr1.nodeName.toLocaleLowerCase() !== 'tr') {
        return;
    }
    carouselTable.insertBefore(tr, tr1);
}
function upload(ele) {
    if (ele.files.length == 0) {
        return;
    }
    let file = ele.files[0]
    if (file.size > 0x100000) {
        alert("文件尺寸请勿超过1MB");
        return;
    }
    if (file.type.substring(0, 5) !== "image") {
        alert("请选择图片文件");
        return;
    }
    let data = new FormData();
    data.append('file', file);
    fetch('/admin/upload', {
        method: "POST",
        body: data,
        credentials: "same-origin"
    }).then(response => {
        if (response.status !== 200) {
            alert("未知错误，请联系统管理员, status:" + response.status);
            return;
        }
        response.json().then(json => {
            let img;
            let imgs = ele.parentElement.querySelectorAll('img.carousel');
            if (imgs.length > 0) {
                img = imgs[0];
            } else {
                img = document.createElement('img');
                img.classList.add('carousel');
                ele.parentElement.insertBefore(img, ele);
            }
            img.setAttribute('src', json.url);
            ele.parentElement.querySelector('input[name=img]').value = json.url;

        });
    }).catch(error => {
        alert("网络错误");
    });
};
creater.querySelector('input[type=file]').setAttribute('onchange', 'upload(this)');
document.querySelector('#new').addEventListener('click', evt => {
    addSpec();
    window.scrollTo(0, document.body.scrollHeight);
});
carouselJson.forEach(item => {
    creater.querySelector('input[name=link]').value = item.link;
    creater.querySelector('input[name=des]').value = item.des;
    if (item.img.length > 0) {
        let hidden = creater.querySelector('input[name=img]');
        hidden.value = item.img;
        let img = document.createElement('img');
        img.classList.add('carousel');
        img.setAttribute('src', item.img);
        hidden.parentElement.insertBefore(img, creater.querySelector('input[type=file]'));
    }
    addSpec();
});
import Vue from 'vue';
import HelloWorld from './components/HelloWorld';

Vue.component('hello-world', HelloWorld);

let app = new Vue({
    el: '#app'
});

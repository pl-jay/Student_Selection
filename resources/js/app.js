
/**
 * First we will load all of this project's JavaScript dependencies which
 * includes Vue and other libraries. It is a great starting point when
 * building robust, powerful web applications using Vue and Laravel.
 */

require('./bootstrap');

window.Vue = require('vue');
import VueRouter from 'vue-router';

/**
 * The following block of code may be used to automatically register your
 * Vue components. It will recursively scan this directory for the Vue
 * components and automatically register them with their "basename".
 *
 * Eg. ./components/ExampleComponent.vue -> <example-component></example-component>
 */

// const files = require.context('./', true, /\.vue$/i)
// files.keys().map(key => Vue.component(key.split('/').pop().split('.')[0], files(key).default))


import SSU from './components/SelectionView.vue';
import FS from './components/FinalSelection.vue';
import US from './components/UltimateSelection.vue';
/**
 * Next, we will create a fresh Vue application instance and attach it to
 * the page. Then, you may begin adding components to this application
 * or customize the JavaScript scaffolding to fit your unique needs.
 */
Vue.use(VueRouter);

const router = new VueRouter({
	routes : [
      // Special Route 
      { path: '/ssuTest', component: SSU, name:'ssu' },
      { path: '/ssuTest2', component: FS, name:'fs' },
      { path: '/ssuTest3', component: US, name:'us' },
    ]
});



const app = new Vue({
    router
}).$mount('#app')

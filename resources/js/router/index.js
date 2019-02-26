import Vue from 'vue'
import Router from 'vue-router'
import SSU from '.././components/SelectionView.vue';


Vue.use(Router)

export default new Router({
	routes : [
      { path: '/ssuTest', component: SSU, name:'ssu' },
    ]
})
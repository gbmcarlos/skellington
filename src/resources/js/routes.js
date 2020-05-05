import HelloWorld from './components/HelloWorld';

export default {
    mode: 'history',
    linkActiveClass: 'font-bold',
    routes: [
        {
            path: '/hello/world',
            component: HelloWorld
        }
    ]
};

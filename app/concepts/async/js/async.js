import Vue from 'vue/dist/vue.esm'

import basemateEventHub from 'core/js/event-hub'

import componentMixin from 'component/js/component'

const componentDef = {
  mixins: [componentMixin],
  data: function(){
    return {
      showing: true,
      hide_after_timeout: null,
      event: {
        data: {}
      }
    }
  },
  methods: {
    show: function(event_data){
      const self = this
      this.showing = true
      this.event.data = event_data
      if(this.componentConfig["hide_after"] != undefined){
        self.hide_after_timeout = setTimeout(function () {
          self.hide()
        }, parseInt(this.componentConfig["hide_after"]));
      }
    },
    hide: function(){
      this.showing = false
      this.event.data = {}
    }
  },
  created: function () {
    const self = this
    basemateEventHub.$on(this.componentConfig["rerender_on"], self.rerender)
    basemateEventHub.$on(this.componentConfig["show_on"], self.show)
    basemateEventHub.$on(this.componentConfig["hide_on"], self.hide)
    if(this.componentConfig["show_on"] != undefined){
      this.showing = false
    }
    if(this.componentConfig["hide_on"] != undefined){
      this.showing = true
    }
  },
  beforeDestroy: function() {
    const self = this
    clearTimeout(self.hide_after_timeout)
    basemateEventHub.$off(this.componentConfig["rerender_on"], self.rerender);
    basemateEventHub.$off(this.componentConfig["show_on"], self.show);
    basemateEventHub.$off(this.componentConfig["hide_on"], self.hide);
  },
}

let component = Vue.component('async-cell', componentDef)

export default componentDef

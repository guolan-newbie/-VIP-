Function.prototype.bind=function(object){
	var method = this;
	return function(){
		method.apply(object,arguments);
	}
}
var rotate = {
		createNew:function(){
			this.a = arr;
			this.timer1='';
			this.div='';
			this.current='';
			this.timer2='';
			this.count=0;
			return this;
		},
		start:function (element){
			if(this.timer2){
				clearInterval(this.timer2);
				this.timer2 = '';
			}
			if(!this.timer1){
				if(typeof element == "string")
				this.div = document.getElementById(element);
				this.div.style["font-size"] = "32pt";
				this.timer1 = setInterval(this.lottery_rotate.bind(this),30);
				this.countdown();
			}
		},
		stop:function (element){
			clearInterval(this.timer1);
			this.timer1 = '';
			document.getElementById(element).innerHTML+="<br/>"+this.current;
			if(!this.timer2){
				this.timer2 = setInterval(this.change.bind(this),100);
			}
		},
		display:function (element){
			document.getElementById(element).innerHTML=this.current;
		},
		lottery_rotate:function (){
			var k = Math.floor(Math.random()*200)%this.a.length;
			this.div.innerHTML=this.a[k];
			this.current = this.a[k];
			this.count--;
			if(this.count==0){
				stop();
			}
		},
		change:function (){
			var size = this.div.style["font-size"];
			if(size=="32pt"){
				this.div.style["font-size"] = "38pt";
			}else{
				this.div.style["font-size"] = "32pt";
			}
		},
		countdown:function(){
			this.count=Math.floor(Math.random()*150)+this.a.length*3;
		}
	}
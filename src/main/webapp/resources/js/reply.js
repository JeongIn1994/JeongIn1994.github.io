
console.log("reply module");
var replyService = (function(){
	
	//regist reply
	function add(reply,callback,error){
		
		console.log("add reply..");
		
		$.ajax({
			type : 'post',
			url : '/replies/new',
			data : JSON.stringify(reply),
			contentType : "application/json; charset-utf-8",
			success : function(result,status,xhr){
				if(callback){
					callback(result);
				}
			},// success end
			error : function(xhr,status,er){
				if(error){
					error(er);
				}
			}//error end
		})//ajax end
	}//2nd function end
	
	//load reply List
	function getList(param,callback,error){
		
		var bno = param.bno;
		var page = param.page || 1;
		
		$.getJSON("/replies/pages/" + bno + "/" + page + ".json",
		  function(data){
			if(callback){
				callback(data.replyCnt,data.list)
			}
		}).fail(function(xhr,status,err){
			if(error){
				error();
			}
		});//fail end
		
	}//getList end
	
	//reply remove
	function remove(rno,callback,error){
		
		$.ajax({
			type : 'delete',
			url : '/replies/' + rno ,
			success : function(deleteResult,status,xhr){
				if(callback){
					callback(deleteResult);
				}
			},
			error : function(xhr,status,er){
				if(error){
					error(er);
				}
			}
		});
	}//remove end
	
	//reply update
	function update(reply,callback,error){
		$.ajax({
			type : 'put',
			url : '/replies/' +reply.rno,
			data : JSON.stringify(reply),
			contentType : "application/json ; charset=utf-8",
			success : function(result,status,xhr){
				if(callback){
					callback(result);
				}
			},
			error : function(xhr,status,er){
				if(error){
					error(er);
				}
			}
		});
	}//update end
	//display Real Time
	function displayTime(timeValue){
		
		var today = new Date();
		
		var gap = today.getTime() - timeValue;
		
		var dateObj = new Date(timeValue);
		var str = "";
		
		//When Time gap was smaller than 1day
		if(gap < (1000*60*60*24)){
			var hh = dateObj.getHours();
			var mi = dateObj.getMinutes();
			var ss = dateObj.getSeconds();
			
			return [ (hh > 9 ? '' : '0') + hh,':',(mi > 9 ? '':'0') + mi, ':',(ss > 9 ? '' : '0') + ss].join('');
		}
		//When Time gap was bigger than 1day
		else{
			var yy = dateObj.getFullYear();
			var mm = dateObj.getMonth() + 1 ;
			var dd = dateObj.getDate();
			
			return [yy+'/'+(mm > 9 ? '' : '0') + mm +'/'+(dd > 9 ? '' : '0') + dd].join();
		}
	};
	return {
		add : add,
		getList : getList,
		remove : remove,
		update : update,
		displayTime : displayTime
	};
}
)();//replyService end
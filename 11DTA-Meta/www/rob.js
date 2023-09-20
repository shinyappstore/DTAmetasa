function addrow(){
  console.log("mo")
  //   let tbl = document.getElementById('rob_tabl');
    
  //   let risk=["low","high","unclear"];
  //   let concern=["low","high","unclear"];

  // //input type=dateをtrに追加
  //   let tr = document.createElement('tr');
  //   let datetd = document.createElement('td');
  //   let dateinp = document.createElement('input');
  //   dateinp.setAttribute('type','date');
  //   datetd.appendChild(dateinp);
  //   tr.appendChild(datetd);
  
  //   createSelect(risk,tr,tbl);
  //   createSelect(concern,tr,tbl);
     
  //    tbl.appendChild(tr);
  }
  
  function createSelect(arr,tr,tbl){
    
    let sl = document.createElement('select');
    let td = document.createElement('td');
    for(let num in arr){
      let op = document.createElement('option');
      op.text = arr[num];
      sl.appendChild(op);
    }
    td.appendChild(sl);
    tr.appendChild(td);
   
  }
  function reset(id){
    let table = document.getElementById(id);
    let rowLen = table.todolists.length;
    for (let i = rowLen-1; i > 0; i--) {
        table.deleteRow(1);
    }
  }
  
   function createSelectRisk (selectIndex=0){
    
    const values=["low","high","unclear"];
    let select = document.createElement("select");
    select.name="risk";
    select.id="rob";
    for (const val of values) {
      let opt=document.createElement("option");
      opt.value=val;
      opt.text=val;
      select.appendChild(opt);
    }
    select.options[selectIndex].selected=true;
    return select;
  }
  // function selecter(str){
  //    if(!isNaN(str))return(str);
  //   if(str.indexO(/l/)){
  //     return(0);
  //   }
  //   if(str.match(/h/)) return 2;
  //   1;
  // }
  function createtablejson(data,id="robtable"){
    let table = document.getElementsByClassName(id)[0];
    if(table.childElementCount>0)
      table.removeChild(table.lastChild);
    let tbl = document.createElement("table");
     tbl.id="robtable";
    let thread=document.createElement("thread");//weird rejected
    let tblBody = document.createElement("tbody");
    for (let i = 0; i < data.length+1; i++) {
      let row =document.createElement("tr");
      if(i==0){
        let th=document.createElement("td");
        th.appendChild(document.createTextNode("Study"));
        row.appendChild(th);
        th=document.createElement("td");
        th.append(document.createTextNode("patient selection"));
        th.setAttribute("colspan","2");
        row.appendChild(th);
        th=document.createElement("td");
        th.append(document.createTextNode("index test"));
        th.setAttribute("colspan","2");
        row.appendChild(th);
        th=document.createElement("td");
        th.append(document.createTextNode("Reference Standart"));
        th.setAttribute("colspan","2");
        row.appendChild(th);
        th=document.createElement("td");
        th.append(document.createTextNode("Flow & timing"));
        row.appendChild(th);
        th=document.createElement("td");
        th.append(document.createTextNode("over all"));
        row.appendChild(th);
        
        tbl.appendChild(row);
        row=document.createElement("tr");
        th=document.createElement("td");
        th.appendChild(document.createTextNode(""));
        row.appendChild(th);
        for(let j =0;j<3;j++){
          th=document.createElement("td");
        th.appendChild(document.createTextNode("bias"));
        row.appendChild(th);
        th=document.createElement("td");
      th.appendChild(document.createTextNode("concern"));
      row.appendChild(th);
        }
        // th.childNodes[0]="bias";
        th=document.createElement("td");
        th.appendChild(document.createTextNode("bias"));
        row.appendChild(th);
        th=document.createElement("td");
        th.appendChild(document.createTextNode("bias"));
        row.appendChild(th);
        tbl.appendChild(row);
        
       continue;
    }
    let study=document.createElement("td");
    study.appendChild(document.createTextNode(data[i-1]["author"]));
    row.appendChild(study);
     for (let j = 0; j < 8;j++) {
     let td = document.createElement("td");
     let tdtext=createSelectRisk(data[i-1]["D"+(j+1).toString()]);    
     td.appendChild(tdtext);
     row.appendChild(td);
    }
      tblBody.appendChild(row);  
    }
    // tbl.appendChild(thread);
    tbl.appendChild(tblBody);
    table.appendChild(tbl);
    tbl.setAttribute("border","2");
  }
  function createtable(n,id="robtable"){
    let table = document.getElementsByClassName(id)[0];
    if(table.childElementCount>0)
      table.removeChild(table.lastChild);
    let tbl = document.createElement("table");
     tbl.id="robtable";
    let thread=document.createElement("thread");//weird rejected
    let tblBody = document.createElement("tbody");
    for (let i = 0; i < n+1; i++) {
      let row =document.createElement("tr");
      if(i==0){
        let th=document.createElement("td");
        th.appendChild(document.createTextNode("Study"));
        row.appendChild(th);
        th=document.createElement("td");
        th.append(document.createTextNode("patient selection"));
        th.setAttribute("colspan","2");
        row.appendChild(th);
        th=document.createElement("td");
        th.append(document.createTextNode("index test"));
        th.setAttribute("colspan","2");
        row.appendChild(th);
        th=document.createElement("td");
        th.append(document.createTextNode("Reference Standart"));
        th.setAttribute("colspan","2");
        row.appendChild(th);
        th=document.createElement("td");
        th.append(document.createTextNode("Flow & timing"));
        row.appendChild(th);
        th=document.createElement("td");
        th.append(document.createTextNode("over all"));
        row.appendChild(th);
        
        tbl.appendChild(row);
        row=document.createElement("tr");
        th=document.createElement("td");
        th.appendChild(document.createTextNode(""));
        row.appendChild(th);
        for(let j =0;j<3;j++){
          th=document.createElement("td");
        th.appendChild(document.createTextNode("bias"));
        row.appendChild(th);
        th=document.createElement("td");
      th.appendChild(document.createTextNode("concern"));
      row.appendChild(th);
        }
        // th.childNodes[0]="bias";
        th=document.createElement("td");
        th.appendChild(document.createTextNode("bias"));
        row.appendChild(th);
        th=document.createElement("td");
        th.appendChild(document.createTextNode("bias"));
        row.appendChild(th);
        tbl.appendChild(row);
        
       continue;
    }
    let study=document.createElement("td");
    study.appendChild(document.createTextNode("study"+i));
    row.appendChild(study);
     for (let j = 0; j < 8;j++) {
     let td = document.createElement("td");
     let tdtext=createSelectRisk();    
     td.appendChild(tdtext);
     row.appendChild(td);
    }
      tblBody.appendChild(row);  
    }
    // tbl.appendChild(thread);
    tbl.appendChild(tblBody);
    table.appendChild(tbl);
    tbl.setAttribute("border","2");
  }
  $("#robstart").on("click",function()
  {
    // let table = document.getElementById("tbl");
    
    // let rowLen = table.rows.length;
    // for (let i = rowLen-2; i > 0; i--) {
    //     table.deleteRow(1);
    // }
    let table = document.getElementsByClassName("robtable")[0];
    console.log(table);
    if(table.childElementCount>0)
      table.removeChild(table.lastChild);
    let tbl = document.createElement("table");
     tbl.id="robtable";
    let thread=document.createElement("thread");//変
    let tblBody = document.createElement("tbody");
    for (let i = 0; i < Math.random()*10+2; i++) {
      let row =document.createElement("tr");
      if(i==0){
        let th=document.createElement("td");
        th.appendChild(document.createTextNode("Study"));
        row.appendChild(th);
        th=document.createElement("td");
        th.append(document.createTextNode("patient selection"));
        th.setAttribute("colspan","2");
        row.appendChild(th);
        th=document.createElement("td");
        th.append(document.createTextNode("index test"));
        th.setAttribute("colspan","2");
        row.appendChild(th);
        th=document.createElement("td");
        th.append(document.createTextNode("Reference Standart"));
        th.setAttribute("colspan","2");
        row.appendChild(th);
        th=document.createElement("td");
        th.append(document.createTextNode("Flow & timing"));
        row.appendChild(th);
        th=document.createElement("td");
        th.append(document.createTextNode("over all"));
        row.appendChild(th);
        
        tbl.appendChild(row);
        row=document.createElement("tr");
        th=document.createElement("td");
        th.appendChild(document.createTextNode(""));
        row.appendChild(th);
        for(let j =0;j<3;j++){
          th=document.createElement("td");
        th.appendChild(document.createTextNode("bias"));
        row.appendChild(th);
        th=document.createElement("td");
      th.appendChild(document.createTextNode("concern"));
      row.appendChild(th);
        }
        // th.childNodes[0]="bias";
        th=document.createElement("td");
        th.appendChild(document.createTextNode("bias"));
        row.appendChild(th);
        th=document.createElement("td");
        th.appendChild(document.createTextNode("bias"));
        row.appendChild(th);
        tbl.appendChild(row);
        
       continue;
    }
    let study=document.createElement("td");
    study.appendChild(document.createTextNode("study"+i));
    row.appendChild(study);
     for (let j = 0; j < 8;j++) {
     let td = document.createElement("td");
    //  let tdtext=document.createTextNode(i+" 行目、 "+j+" 列目のセル");
    
    let tdtext=createSelectRisk();
    
     td.appendChild(tdtext);
    //  td.setAttribute("colspan","1");
      row.appendChild(td);
     }
      tblBody.appendChild(row);  
    }
    // tbl.appendChild(thread);
    tbl.appendChild(tblBody);
    table.appendChild(tbl);
    tbl.setAttribute("border","2");
console.log(table);
  }
  )
  $("#mochii").on("click",function(){
//     let study=document.getElementById("manualInput");
//     console.log(study);
//     let table = document.getElementById("tbl");
//     console.log(table);
// console.log(table.children[1]);
// let chi=table.children[1];
// console.log(table.children[1].childElementCount);
// console.log(table.rows[2].cells[1].children[0].value);
// console.log(document.getElementById("pet-select"));
//Shiny.onInputChange("aaaaaaa",Math.random()); 古い
Shiny.setInputValue("aaaaaaa",Math.random());

// for (let i = 0; i < table.rows.length; i++) {
//   if(i>1){
//     for(let j=0;j<table.cells.length;j++){

//     }
//   }
  
// }
  })
// $("#filer_rob").change(function(){
//   let file= document.getElementById("filer_rob");
//   console.log(file.value);
//   let reader=new FileReader();
//   console.log(reader.readAsText(file.value,"UTF-8"));
  
// })
  Shiny.addCustomMessageHandler('studylength',function(message){
    createtable(message);
    console.log("mo");
  })
  Shiny.addCustomMessageHandler("robfile",function(message){
     createtablejson(message);
  })
  $("#getrobtable").on("click",function(){
    let table = document.getElementsByClassName("robtable")[0].children[0];
    let tb="study,D1,D2,D3,D4,overall";
    let tc="study,D1,D2,D3";
    for (let i =0;i<table.rows.length-2;i++) {
      tb+="\n"+table.rows[i+2].cells[0].innerText;
      tc+="\n"+table.rows[i+2].cells[0].innerHTML;//same mean innerText innerHTML
      for(let j=0; j<table.rows[2].cells.length-1;j++)//j<7
      {
        if(j % 2 === 0||j==table.rows[2].cells.length-2){
          tb+=",";
          tb+=table.rows[i+2].cells[j+1].children[0].value;//select
          console.log(table.rows[i+2].cells[j+1].selectIndex);
        }
        else{
          tc+=",";
          tc+=table.rows[i+2].cells[j+1].children[0].value;
        }
      }

    }
    Shiny.setInputValue("robtablejson",tb);//input$robtablejson　Variable acquisition in shiny server from javascript
    Shiny.setInputValue("robtablejson_c",tc);
  })
  // $(function() {
  //   $("#swallow_wrapper").on('shiny:inputchanged', function(event) {
  //     event.preventDefault();
  //   });
  //   $(document).on({
  
  //     'shiny:connected': function(event) {
  //       $('form.well').fadeOut(3000).fadeIn(2000);
  //     },
  
  //     'shiny:disconnected': function(event) {
  //       alert('Disconnected! The web socket state is ' + event.socket.readyState);
  //     },
  
  //     'shiny:busy': function(event) {
  //       $('#busyModal').modal('show');
  //     },
  
  //     'shiny:idle': function(event) {
  //       $('#busyModal').modal('hide');
  //     },
  
  //     'shiny:inputchanged': function(event) {
  //       switch (event.name) {
  
  //         // modify the title value during the event
  //         case 'title':
  //           event.value += ' (title modified by the JS event based on input$title)';
  //           break;
  
  //         // cancel the event so this button does not update the color
  //         case 'color2':
  //           event.preventDefault();
  //           break;
  
  //         default:
  
  //       }
  //     },
  
  //     'shiny:message': function(event) {
  //       console.log('Received a message from Shiny');
  //       var msg = event.message;
  //       if (msg.hasOwnProperty('custom') && msg.custom.hasOwnProperty('special')) {
  //         console.log('This is a special message from Shiny:');
  //         console.log(msg.custom.special);
  //       } else if (msg.hasOwnProperty('custom') && msg.custom.hasOwnProperty('swallow_fail')) {
  //         alert(msg.custom.swallow_fail.msg);
  //       }
  //     },
  
  //     'shiny:bound': function(event) {
  //       console.log('An ' + event.bindingType + ' (' + event.binding.name + ') was bound to Shiny');
  //     },
  
  //     'shiny:updateinput': function(event) {
  //       console.log({
  //         'Input message': event.message,
  //         'To be applied to': event.target
  //       });
  //     },
  
  //     'shiny:value': function(event) {
  //       if (event.name === 'slider_info2') {
  //         event.value = 'My output was modified by the shiny:value event.';
  //       }
  //     },
  
  //     'shiny:error': function(event) {
  //       if (event.name === 'error_info') {
  //         event.error.message = 'A nice error occurred :)';
  //       }
  //     },
  
  //     'shiny:recalculating': function(event) {
  //       console.log('An output is being recalculated... ' + new Date());
  //     },
  
  //     'shiny:recalculated': function(event) {
  //       console.log('An output has been recalculated! ' + new Date());
  //     }
  
  //   });
  
  //   // when the slider input is bound, add a red border to it
  //   $('#bins').on('shiny:bound', function(event) {
  //     $(this).parent().css('border', 'dotted 2px red');
  //   });
  
  //   Shiny.addCustomMessageHandler('special', function(message) {
  //     //
  //   });
  // });
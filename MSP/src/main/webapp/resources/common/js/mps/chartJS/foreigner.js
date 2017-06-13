//데이터 불러오기 > 축과 척도 설정 > 틀 그리기 > 축 그리기 
//> 요소에 데이터 엮기 > 요소 속성 설정

//데이터 불러오기
	 	
function chart(){
	//$(".d3test").empty();	//기존 내용 지우기
	//$(".d3test").html("");  //기존 내용 지우기
 	d3.json("search_list2", function (data){

	//var data = new Array;
	//data = "<c:out value='${dthree_list}'/>";
	
	console.log(data);
	console.log(data.dthree_list);
// 	alert("data : "+data.dthree_list);
 	
	//데이터 변환하기
	data.dthree_list.forEach(function(d){
		  d.area =+ d.area; 
	      d.korea =+ d.korea;
	      d.foreigner =+ d.foreigner;
	      console.log(d);
//	      alert(d.korea);
//	      alert(d);
	});
 
 //가로, 세로, 여백 설정
// var margin = { top: 20, right: 200, bottom: 20, left: 20 },
 var margin = { top: 20, right: 20, bottom: 20, left: 120 },
     width = 600 - margin.left + margin.right,
     height = 280 - margin.top - margin.bottom;
 
 //x,y 척도 설정
 var xScale = d3.scaleLinear()
                .domain([0, d3.max(data.dthree_list, function(d) { return d.korea; })])
                .range([0, width]);
 
 var yScale = d3.scaleLinear()
             .domain([0, d3.max(data.dthree_list, function(d) { return d.foreigner; })])
             .range([height, 0]);
             
 //x축 설정
 var xAxis = d3.axisBottom()
            .scale(xScale);
 
 //y축 설정
 var yAxis = d3.axisLeft()
               .scale(yScale);
 
 //SVG 틀 그리기
 var svg = d3.select(".d3test")
             .append("svg")
             .attr("width", width + margin.left + margin.right)
             .attr("height", height + margin.top + margin.bottom )
             .append("g")
             .attr("transform", "translate(" + margin.left + ", " + margin.top + ")");
 
 //X축 그리기
 svg.append("g")
    .attr("class", "axis")
    .attr("transform", "translate(0," + height + ")")
    .call(xAxis)
    .append("text")
    .text("내국인")
    .attr("transform", "translate(" + (width - margin.right) + ", -10)");
 
 //y축 그리기
 svg.append("g")
    .attr("class", "axis")
    .call(yAxis)
    .append("text")
    .text("외국인")
    
 //산포도 점 찍기   
  svg.selectAll("circle")
     .data(data.dthree_list)
     .enter()
     .append("circle")
     .attr("cx", function (d) {
        return xScale(d.korea);
     })
     .attr("cy", function(d) {
        return yScale(d.foreigner);
     })
     .attr("r", 5)
     .attr("fill", "#19BDC4");
 
 //점에 데이터명 붙이기
 svg.selectAll(".labeltext")
    .data(data.dthree_list)
    .enter()
    .append("text")
    .text(function (d) {
    	//alert(d.area);
       return d.area;
    })
    .attr("x", function (d) {
       return xScale(d.korea);
    })
    .attr("y", function (d) {
       return yScale(d.foreigner) - 10;
    })
    .attr("font-family", "sans-serif")
    .attr("font-size", "10px")
    .attr("fill", "#888888")
    .attr("text-anchor", "middle");
    

});
 	}
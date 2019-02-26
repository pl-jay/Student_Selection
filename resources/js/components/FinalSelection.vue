<template>
<div>
	<div class="row">
		<div class="card" style="width: 500px; !important">
			<div class="card-body">
				<table class="table table-bordered table-sm">
  					<thead>
    					<tr>
      						<th class="bg-primary">Degree Programme</th>
      						<th class="bg-primary">Students Limit</th>
   						</tr>
  					</thead>
  					<tbody>
    					<tr v-for="sbj in subjectList.subject">
      						<td>{{ sbj.program }}</td>
      						<td><input  type="number" v-model.number="sbj.limit"></td>
    					</tr>
  					</tbody>
				</table>
			</div>
		</div>
		<div class="card">
			<div class="card-body">
				<h2><a class="btn btn-primary" @click="SubjectTable()">LoadData</a></h3>
				<h2><a class="btn btn-primary" @click="SubjectTable()">LoadData</a></h3>
				<h2><a class="btn btn-primary" @click="SubjectTable()">LoadData</a></h3>
			</div>
		</div>
	</div>
</div>
</template>

<script>
	export default{

		data: function(){
			return{
				programe:    '',
				list_no:     '',
				std_limit:   '',
                subjectid:   '',
				
				subjectList: {
					subject:[],
				},
				choosen_studentList:{},
				final_List : [],

				// Main Threee List
				list1: {},
				list2: {},
				list3: {},

				// Programme and limit
				listOfStudentlimits:[],
			}
		},

		mounted() {
			var app = this;
            axios.get('/api/ssu/subjectList')
            .then(response => {
                app.subjectList.subject = response.data
                console.log(app.subjectList.subject)
            })
        },

        methods:{
			
			SubjectTable(){
				var app = this;
			console.log(app.subjectList.subject)
				axios.post('/api/ssu/fillSubjectTable', app.subjectList)
					.then(response =>{
						console.log(response.data)
					})
			},

        	loadData(){

				// this will fill the three lists with prg, option & limit parameters
        		var app = this;

				// this will empty the final list array
        		app.final_List = []
        		console.log(app.subjectList.subject.length)
        		for (var i = 0; i < app.subjectList.subject.length-1; i++) {
        			
        			var std_limit   = app.subjectList.subject[i].limit
        			//var subj_id 	= app.subjectList.subject[i].choice_id

					var subj_id = app.subjectid                    
        			console.log(std_limit,subj_id)

        			axios.get('/api/ssu/test/'+ subj_id)
        			 	.then(response =>{
        			 		
        			 		app.list1 = response.data[0]
        			 		console.log('fill list 1',app.list1)

        			 		app.list2 = response.data[1]
        			 		console.log('fill list 2', app.list2)

        			 		app.list3 = response.data[2]
        			 		console.log('fill list 3', app.list3)


        			 		this.selection_logic(std_limit)

        			 	})

        		}
        	},


        	selection_logic(limit){
        		var app = this;
        		
        		var list1_length = app.list1.length;
        		var list2_length = app.list2.length;
        		var list3_length = app.list3.length;

        		var due_no1,due_no2,due_no3;

        		console.log('list1_length',app.list1.length)
        		
        		if(list1_length < limit){

        			/* print out */
					console.log('list1_lenght',list1_length)
        			/* end */

        			/* Array Operation */
        			for (var i = 0; i <= list1_length-1; ++i) {
        				app.final_List.push(app.list1[i])
        			}
        			
        			due_no1 = limit - list1_length
        			/* end */
        			
        			/* print out */
						console.log('due_no1',due_no1)
        			
        				console.log('Final List first if', app.final_List)
        			/* end */

        			
        			if(list2_length < due_no1){
        				
        				/* print out */
        				console.log('list2_lenght',list2_length)
        				/* end */

        				/* Array Operation */
        				
        				for (var i = 0; i <= list2_length-1; ++i) {
        					app.final_List.push(app.list2[i])
        				}
        				
        				due_no2 = due_no1 - list2_length
        				
        				/* end */
        				
        				/* print out */
        				console.log('Final List second if', app.final_List)
        				console.log('due_no2',due_no2)
        				/* end */

        			
        				if(list3_length < due_no2){
        					
        					/* print out */
        					console.log('list3_lenght',list3_length)
        					/* end */

        					/* Array Operation */
        					
        					for (var i = 0; i <= list3_length-1; ++i) {
        						app.final_List.push(app.list3[i])
        					}

        					due_no3 = due_no2 - list3_length
        					/* end */

        					/* print out */
        					
        					console.log('Final List third if', app.final_List)
        					console.log('due_no3',due_no3)

        					/* end */

        				} else{
        					/* print out */
        					console.log('else of list3_length')
        					/* end */


        					/* Array Operation */
        					
        					for (var i = 0; i <= due_no2-1; ++i) {
        						app.final_List.push(app.list3[i])
        					}

        					/* end */

        					/* print out */
        					
        					console.log('Final List third if-else', app.final_List)
        				
        					/* end */

        				}

        			} else{
        				

        					/* Array Operation */
        					
        					for (var i = 0; i <= due_no1-1; ++i) {
        						app.final_List.push(app.list2[i])
        					}
        					
        					/* end */

        					/* print out */
        					
        					console.log('Final List second if-else', app.final_List)
        				
        					/* end */

        			}

        		}else{
        			/* Array Operation */
        			
        			for (var i = 0; i <= limit-1; ++i) {
        				app.final_List.push(app.list1[i])
        			}

        			/* end */

        			/* print out */
        					
        				console.log('Final List first if-else', app.final_List)
        				
        			/* end */
        		}
        	},


        	confirm_list(para){
        		var app = this;
        		console.log('NIC', app.final_List[2].nic)
        	},

        	filterByALStream(){

        	}
        }
	}
</script>

<template>
<div>
    <div class="row">
   <!--  <button type="button" class="btn btn-primary btn-sm" @click=' 
            homepage    = true,
            newrec_view = false,
            list_view   = false' >Home</button>
 -->
    <button type="button" class="btn btn-primary btn-sm" @click=' 
            homepage    = false,
            newrec_view = true,
            list_view   = false' >Add New Record</button>

    <button type="button" class="btn btn-primary btn-sm"  @click='
            homepage    = false,
            newrec_view = false,
            list_view   = true'>Show whole List</button>

    <button type="button" class="btn btn-primary btn-sm"  @click='
            homepage    = false,
            newrec_view = false,
            list_view   = true'>Show filtered List</button>

    <button type="button" class="btn btn-primary btn-sm"  @click='
            changeView()'>Show </button>

    <button type="button" class="btn btn-primary btn-sm"  @click='
            homepage    = false,
            newrec_view = false,
            list_view   = true'>Show List</button>
    </div>

    <div class="row" style="padding-top:10px; !important">
        <div class="col-md-12">
        <ul class="pagination">
  <li class="page-item" v-for="sbj in subjectList">
    <a class="page-link" nav-link="">{{sbj.program}}</a>
  </li>
</ul>
</div>
    </div>


    <div>
        <div v-if="homepage == true">
            <h1>Home View !</h1>
        </div>
<!--#region form -->
        <div class="col-12" v-if="newrec_view == true">
            

            <div class="form-group">
                <label for="candidateName">Name: </label>
                <input type="text" class="form-control" id="candidateName" name="candidateName" placeholder="Candidate Name" v-model="candidate.name" > 
            </div>

            <div class="form-group">
                <label for="candidateAddress">Address: </label>
                <input type="text" class="form-control" id="candidateAddress" name="candidateAddress" placeholder="Candidate Address" v-model="candidate.address"> 
            </div>

            <div class="form-group">
                <label for="dob">Date of Birth: </label>
                <div class='input-group date' >
                    <input type='date' class="form-control" id='dob' name="dob" v-model="candidate.dob"/>
                </div>
            </div>

            <div class="form-group">
               <label for="candidateNIC">NIC: </label>
               <input type="text" class="form-control" id="candidateNIC" name="candidateNIC" placeholder="Candidate NIC" v-model="candidate.nic"> 
            </div>

            <div class="form-group">
                <label for="candidateALStream">A/L Stream: </label>
                <input type="text" class="form-control" id="candidateALStream" name="candidateALStream" placeholder="Candidate A/L Stream" v-model="candidate.alstream"> 
            </div>

            <div class="row">
                <div class="col-md-4">
                    <label for="options">Option 1: </label>
                    <div class=" radio" v-for="sbj in subjectList">
                        <label>
                            <input type="radio" name="optr1adio"
                                v-model="candidate.option1" 
                                v-bind:value="sbj.choice_id">{{ sbj.program }}
                            </label>
                    </div>
                    
                </div>
               
               <div class="col-md-4">
                    <label for="options">Option 2: </label>
                    <div class=" radio" v-for="sbj in subjectList">
                        <label>
                            <input type="radio" name="optr2adio"
                                v-model="candidate.option2" 
                                v-bind:value="sbj.choice_id">{{ sbj.program }}
                            </label>
                    </div>
               </div>

                <div class="col-md-4">
                    <label for="options">Option 3: </label>
                    <div class=" radio" v-for="sbj in subjectList">
                        <label>
                            <input type="radio" name="optr3adio"
                                v-model="candidate.option3" 
                                v-bind:value="sbj.choice_id">{{ sbj.program }}
                            </label>
                    </div>
                </div>
                
            </div>
            
            <div class="form-group" v-if="">
                    
            </div>
            
            <div class="form-group">
                 <label>Z-Score: </label>
                 <input type="number" class="form-control" id="candidatezscore" name="candidatezscore" placeholder="Candidate Z-Score" v-model="candidate.zscore">
            </div>
               
    <div class="btn-group" role="group">

    <button type="button" class="btn btn-primary" @click='addtoarray()'><h5>Next Record</h5></button>

    <button type="button" class="btn btn-primary"  @click='save()'><h5>Save</h5></button>
    </div>
            
    </div>
<!-- #endregion -->

        <div v-if="list_view == true">
            <div class="form-group form-inline" style="padding-top: 50px;padding-bottom: 20px;">
                <p>Subject : </p>
                <select  class="form-control" name="subject" id="subject" v-model="filterby.subject_id">
                    <option v-for="sbj in subjectList" v-bind:value="sbj.choice_id">{{ sbj.program }}</option>
                </select>
            <p>Method :</p>
                <select  class="form-control" name="method" id="method" v-model="filterby.filter_method">
                    <option value="fst">First Option only</option>
                    <option value="sec">First and Second Options</option>
                    <option value="thrd">First, Second and Third Options</option>
                </select>

                <button class="btn btn-primary" @click="filter(filterby.subject_id, filterby.filter_method)">Search</button>
                
            </div>
            <div class="row">
                <div class="col-md-6">
                    <table v-if="filtered == true" class="table table-bordered table-striped">
                <thead>
                    <td>Name</td>
                    <td>NIC</td>
                    <td>A/L Stream</td>
                    <td>Z-Score</td>
                </thead>
                <tbody>
                    <tr v-for="cand in candidates">
                        <td>{{ cand.cand_name }}</td>
                        <td>{{ cand.nic }}</td>
                        <td>{{ cand.alstream }}</td>
                        <td>{{ cand.zscore }}</td> 
                    </tr> 
                </tbody>
            </table>
                </div>
                <div class="col-md-6">
                    <table v-if="filtered == true" class="table table-bordered table-striped">
                <thead>
                    <!-- <td>Name</td> -->
                    <td>NIC</td>
                    <td>A/L Stream</td>
                    <td>Z-Score</td>
                    <td>Option1</td>
                    <td>Option2</td>
                    <td>Option3</td>
                </thead>
                <tbody>
                    <tr v-for="cand in candidateList">
                        <!-- <td>{{ cand.cand_name }}</td> -->
                        <td>{{ cand.nic }}</td>
                        <td>{{ cand.alstream }}</td>
                        <td>{{ cand.zscore }}</td> 
                        <td>{{ cand.option1 }}</td> 
                        <td>{{ cand.option2 }}</td> 
                        <td>{{ cand.option3 }}</td> 
                    </tr> 
                </tbody>
            </table>
                </div>
            </div>
            


        </div>
    </div>
</div>
</template>

<script>

export default{

    data: function() {
        return{
            
            // view changin  booleans 
            homepage:    true,
            newrec_view: false,
            list_view:   false,
            filtered:    false,

            

            // filtering view var
            candidates:   {},
            candidateList:{},
            options:      {},
            subjectList:  {},
            filterby:{
                subject_id:'',
                filter_method:''
            },

            // form view var
            candidate:{
                name:       '',
                address:    '',
                dob:        '',
                nic:        '',
                alstream:   '',
                zscore:     '',
                option1:    '',
                option2:    '',
                option3:    ''
            },

            candidate_array:{}


        }
        
    },
    mounted(){
    
    var app = this;
        axios.get('/api/ssu/subjectList')
            .then(response => {
                app.subjectList = response.data
            })     

        axios.get('/api/ssu/candlist')
            .then(response =>{
                app.candidateList = response.data[0]
                console.log(response)
        }) 
    },

    methods: {

       save(){
        axios.post('/api/ssu/saveCand', this.candidate)
             .then(response =>{
                alert('success !')
             })
       },

       filter(id, meth){
        var app = this;
        axios.get('/api/ssu/filterCand/'+ id + '/' + meth )
            .then(response =>{
               app.candidates = response.data
               app.filtered   = true
            })
       },

       changeView(){
        app.homepage    = true,
        app.newrec_view = false,
        app.list_view   = false,
        app.filtered    = false
       },

       addtoarray(){
        var app = this;
            app.candidate_array.push(app.candidate)
            console.log(app.candidate_array)
       }

    }

}
        
</script>
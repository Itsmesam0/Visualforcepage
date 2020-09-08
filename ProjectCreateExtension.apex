public class ProjectCreateExtension {
	private ApexPages.StandardController sce;
    public Sprint__c sprint {get;set;}
    public List<Sprint__c> sprints {get; set;}	
    public String selectedSprint {get; set; }
    public Story__c story {get;set;}
    public List<Story__c> stories {get; set;}	
    
    public ProjectCreateExtension(ApexPages.StandardController standardController){
        sce=standardController;
        sprint=new Sprint__c();
        sprints = new List<Sprint__c>();
        story=new Story__c();
        stories=new List<Story__c>();
        
       	// Project__c project = (Project__c)sc.GetRecord();
		//sprint.Project__c = project.Id;
		//update sprint;
    }
    
    public PageReference ToPage1(){
        return Page.ProjectCreate1;
    }
    
     public PageReference ToPage2(){
         if(ApexPages.currentPage().GetURL().ToLowerCase().startsWith('/apex/ProjectCreate1')){
             sce.save();
             system.debug('Saved ');
             Project__c project = (Project__c)sce.GetRecord();
             sprints = [select Id, Name, Start_Date__c from Sprint__c
             			  where Project__c = : project.Id];
         }
         sce.save();
        return Page.ProjectCreate2;
    }
    
     public PageReference ToPage3(){
        // selectedSprint=sprint.Id;
        stories=[Select Id,Theme__c, Points__c,Story__c from Story__c where Sprint__c =:selectedSprint];
        return Page.ProjectCreate3;
    }
    
    public PageReference SaveSprint(){
        Project__c project = (Project__c)sce.GetRecord();
        sprint.Project__c = project.Id;
        insert sprint;
        sprints.Add(sprint);
        sprint = new Sprint__c();
        return null;
    }
    
    public PageReference SaveStory(){
        story.Sprint__c=selectedSprint;
        insert story;
        
        stories.add(story);
        story=new Story__c();
        
        return null;
    }
    
}
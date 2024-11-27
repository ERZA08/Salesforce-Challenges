trigger opportunityTrigger on Opportunity (before insert) {

    System.debug('So this is a trigger to do something');

}
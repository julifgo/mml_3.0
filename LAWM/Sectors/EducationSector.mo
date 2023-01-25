within LAWM.Sectors;
package EducationSector
  block Enrolment
   // Parameters
   parameter Real maxEnrolmentPercentage = 98;

   // Input vars:
   LAWM.Utilities.Interfaces.RealInput availableEducationSlots annotation(Placement(visible = true, transformation(origin = {-120, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
   LAWM.Utilities.Interfaces.RealInput population7to18 annotation(Placement(visible = true, transformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));

   // Output vars
   LAWM.Utilities.Interfaces.RealOutput enrolmentPercentage annotation( Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

  protected
  Real grossEnrolmentPercentage;
   equation
     grossEnrolmentPercentage = 100.*availableEducationSlots/population7to18;
     enrolmentPercentage = min(grossEnrolmentPercentage,maxEnrolmentPercentage);
  end Enrolment;

  block Matriculation
   // Parameters
   parameter Real maxMatriculationPercentage = 98;
    //Input vars:
    LAWM.Utilities.Interfaces.RealInput availableEducationSlots annotation( Placement(visible = true, transformation(origin = {-120, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    LAWM.Utilities.Interfaces.RealInput totalPopulation annotation( Placement(visible = true, transformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    // Output vars:
    LAWM.Utilities.Interfaces.RealOutput matriculationPercentage annotation( Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  protected
  Real grossMatriculationPercentage;
  equation
    grossMatriculationPercentage = 100.*availableEducationSlots/totalPopulation;
    matriculationPercentage = min(grossMatriculationPercentage,maxMatriculationPercentage);
  end Matriculation;

  block EducationSectorPhysicalOutput
     //Inputs
     LAWM.Utilities.Interfaces.RealInput gnpEducationSector annotation(
      Placement(visible = true, transformation(origin = {-120, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
     LAWM.Utilities.Interfaces.RealInput costPerEducationSlot annotation(
      Placement(visible = true, transformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
     //Outputs
     LAWM.Utilities.Interfaces.RealOutput availableEducationSlots annotation(
        Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
   equation
     availableEducationSlots = gnpEducationSector/costPerEducationSlot; // (1)
  end EducationSectorPhysicalOutput;

  block EducationSector
    // Parameters
    parameter Real maxEnrolmentPercentage;
    parameter Real maxMatriculationPercentage;
    // Components
    LAWM.Sectors.EducationSector.EducationSectorPhysicalOutput education_phyout();
    LAWM.Sectors.EducationSector.Matriculation matriculation(maxMatriculationPercentage);
    LAWM.Sectors.EducationSector.Enrolment enrolment(maxEnrolmentPercentage);
    // Inputs
    discrete LAWM.Utilities.Interfaces.RealInput population7to18      annotation ( Placement(visible = true , transformation(origin = {-110 , -90 } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0) , iconTransformation(origin = {-110 , -90 } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0)));
    discrete LAWM.Utilities.Interfaces.RealInput totalPopulation      annotation ( Placement(visible = true , transformation(origin = {-110 , -30 } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0) , iconTransformation(origin = {-110 , -30 } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0)));
    discrete LAWM.Utilities.Interfaces.RealInput gnpEducationSector   annotation ( Placement(visible = true , transformation(origin = {-110 ,  30 } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0) , iconTransformation(origin = {-110 ,  30 } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0)));
    discrete LAWM.Utilities.Interfaces.RealInput costPerEducationSlot annotation ( Placement(visible = true , transformation(origin = {-110 ,  90 } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0) , iconTransformation(origin = {-110 ,  90 } , extent = {{-10 , -10 } , {10 , 10 }  } , rotation = 0)));
    // Outputs
    discrete LAWM.Utilities.Interfaces.RealOutput enrolmentPercentage     annotation ( Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    // Enrolment:
      // Inputs
    enrolment.availableEducationSlots     = education_phyout.availableEducationSlots;
    enrolment.population7to18             = population7to18;
      // Outputs
    enrolmentPercentage = enrolment.enrolmentPercentage;
    // Matriculation
      // Inputs
      matriculation.availableEducationSlots = education_phyout.availableEducationSlots;
      matriculation.totalPopulation         = totalPopulation;
    // Physical Output: Education
      // Inputs
      education_phyout.gnpEducationSector   = gnpEducationSector;
      education_phyout.costPerEducationSlot = costPerEducationSlot;
   end EducationSector;

end EducationSector;

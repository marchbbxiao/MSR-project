<ParaView>
  <ServerManagerState version="6.1.0">
    <Proxy group="animation" type="AnimationScene" id="263" servers="16">
      <Property name="AnimationTime" id="263.AnimationTime" number_of_elements="1">
        <Element index="0" value="1"/>
      </Property>
      <Property name="Cues" id="263.Cues" number_of_elements="1">
        <Proxy value="265"/>
        <Domain name="groups" id="263.Cues.groups"/>
      </Property>
      <Property name="EndTime" id="263.EndTime" number_of_elements="1">
        <Element index="0" value="2"/>
      </Property>
      <Property name="ForceDisableCaching" id="263.ForceDisableCaching" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="263.ForceDisableCaching.bool"/>
      </Property>
      <Property name="FramesPerTimestep" id="263.FramesPerTimestep" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="263.FramesPerTimestep.range"/>
      </Property>
      <Property name="GoToFirst" id="263.GoToFirst"/>
      <Property name="GoToLast" id="263.GoToLast"/>
      <Property name="GoToNext" id="263.GoToNext"/>
      <Property name="GoToPrevious" id="263.GoToPrevious"/>
      <Property name="InPlay" id="263.InPlay">
        <Domain name="bool" id="263.InPlay.bool"/>
      </Property>
      <Property name="LockEndTime" id="263.LockEndTime" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="263.LockEndTime.bool"/>
      </Property>
      <Property name="LockStartTime" id="263.LockStartTime" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="263.LockStartTime.bool"/>
      </Property>
      <Property name="Loop" id="263.Loop" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="263.Loop.bool"/>
      </Property>
      <Property name="NumberOfFrames" id="263.NumberOfFrames" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="263.NumberOfFrames.range"/>
      </Property>
      <Property name="Play" id="263.Play"/>
      <Property name="PlayMode" id="263.PlayMode" number_of_elements="1">
        <Element index="0" value="2"/>
        <Domain name="enum" id="263.PlayMode.enum">
          <Entry value="0" text="Sequence"/>
          <Entry value="2" text="Snap To TimeSteps"/>
        </Domain>
      </Property>
      <Property name="Reverse" id="263.Reverse"/>
      <Property name="StartTime" id="263.StartTime" number_of_elements="1">
        <Element index="0" value="1"/>
      </Property>
      <Property name="Stop" id="263.Stop"/>
      <Property name="Stride" id="263.Stride" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="263.Stride.range"/>
      </Property>
      <Property name="TimeKeeper" id="263.TimeKeeper" number_of_elements="1">
        <Proxy value="256"/>
      </Property>
      <Property name="ViewModules" id="263.ViewModules" number_of_elements="1">
        <Proxy value="326"/>
        <Domain name="groups" id="263.ViewModules.groups"/>
      </Property>
    </Proxy>
    <Proxy group="animation" type="TimeAnimationCue" id="265" servers="16">
      <Property name="AnimatedDomainName" id="265.AnimatedDomainName" number_of_elements="1">
        <Element index="0" value=""/>
      </Property>
      <Property name="AnimatedElement" id="265.AnimatedElement" number_of_elements="1">
        <Element index="0" value="0"/>
      </Property>
      <Property name="AnimatedPropertyName" id="265.AnimatedPropertyName" number_of_elements="1">
        <Element index="0" value="Time"/>
      </Property>
      <Property name="AnimatedProxy" id="265.AnimatedProxy" number_of_elements="1">
        <Proxy value="256"/>
        <Domain name="groups" id="265.AnimatedProxy.groups"/>
      </Property>
      <Property name="Enabled" id="265.Enabled" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="265.Enabled.bool"/>
      </Property>
      <Property name="EndTime" id="265.EndTime" number_of_elements="1">
        <Element index="0" value="1"/>
      </Property>
      <Property name="KeyFrames" id="265.KeyFrames">
        <Domain name="groups" id="265.KeyFrames.groups"/>
      </Property>
      <Property name="LastAddedKeyFrameIndex" id="265.LastAddedKeyFrameIndex"/>
      <Property name="StartTime" id="265.StartTime" number_of_elements="1">
        <Element index="0" value="0"/>
      </Property>
      <Property name="TimeMode" id="265.TimeMode" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="265.TimeMode.enum">
          <Entry value="0" text="Normalized"/>
          <Entry value="1" text="Relative"/>
        </Domain>
      </Property>
      <Property name="UseAnimationTime" id="265.UseAnimationTime" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="265.UseAnimationTime.bool"/>
      </Property>
    </Proxy>
    <Proxy group="misc" type="ViewLayout" id="327" servers="20">
      <Property name="PreviewMode" id="327.PreviewMode" number_of_elements="2">
        <Element index="0" value="0"/>
        <Element index="1" value="0"/>
      </Property>
      <Property name="SeparatorColor" id="327.SeparatorColor" number_of_elements="3">
        <Element index="0" value="0.937"/>
        <Element index="1" value="0.922"/>
        <Element index="2" value="0.906"/>
        <Domain name="range" id="327.SeparatorColor.range"/>
      </Property>
      <Property name="SeparatorWidth" id="327.SeparatorWidth" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="327.SeparatorWidth.range"/>
      </Property>
      <Layout number_of_elements="1">
        <Item direction="0" fraction="0.5" view="326"/>
      </Layout>
    </Proxy>
    <Proxy group="lookup_tables" type="PVLookupTable" id="6953" servers="21">
      <Property name="AboveRangeColor" id="6953.AboveRangeColor" number_of_elements="3">
        <Element index="0" value="0.5"/>
        <Element index="1" value="0.5"/>
        <Element index="2" value="0.5"/>
      </Property>
      <Property name="ActiveAnnotatedValues" id="6953.ActiveAnnotatedValues"/>
      <Property name="AllowDuplicateScalars" id="6953.AllowDuplicateScalars" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6953.AllowDuplicateScalars.bool"/>
      </Property>
      <Property name="Annotations" id="6953.Annotations"/>
      <Property name="AnnotationsInitialized" id="6953.AnnotationsInitialized" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6953.AnnotationsInitialized.bool"/>
      </Property>
      <Property name="AutomaticDataHistogramComputation" id="6953.AutomaticDataHistogramComputation" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6953.AutomaticDataHistogramComputation.bool"/>
      </Property>
      <Property name="AutomaticRescaleRangeMode" id="6953.AutomaticRescaleRangeMode" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="6953.AutomaticRescaleRangeMode.enum">
          <Entry value="-1" text="Never"/>
          <Entry value="0" text="Grow and update on &#x27;Apply&#x27;"/>
          <Entry value="1" text="Grow and update every timestep"/>
          <Entry value="2" text="Update on &#x27;Apply&#x27;"/>
          <Entry value="3" text="Clamp and update every timestep"/>
          <Entry value="4" text="Rescale to visible data range on &#x27;Apply&#x27;"/>
          <Entry value="5" text="Rescale to visible data range every timestep"/>
        </Domain>
      </Property>
      <Property name="BelowRangeColor" id="6953.BelowRangeColor" number_of_elements="3">
        <Element index="0" value="0"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0"/>
      </Property>
      <Property name="Build" id="6953.Build"/>
      <Property name="ColorSpace" id="6953.ColorSpace" number_of_elements="1">
        <Element index="0" value="2"/>
        <Domain name="enum" id="6953.ColorSpace.enum">
          <Entry value="0" text="RGB"/>
          <Entry value="1" text="HSV"/>
          <Entry value="2" text="Lab"/>
          <Entry value="3" text="Diverging"/>
          <Entry value="4" text="Lab/CIEDE2000"/>
          <Entry value="5" text="Step"/>
        </Domain>
      </Property>
      <Property name="DataHistogramNumberOfBins" id="6953.DataHistogramNumberOfBins" number_of_elements="1">
        <Element index="0" value="10"/>
      </Property>
      <Property name="Discretize" id="6953.Discretize" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6953.Discretize.bool"/>
      </Property>
      <Property name="EnableOpacityMapping" id="6953.EnableOpacityMapping" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6953.EnableOpacityMapping.bool"/>
      </Property>
      <Property name="HSVWrap" id="6953.HSVWrap" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6953.HSVWrap.bool"/>
      </Property>
      <Property name="IndexedColors" id="6953.IndexedColors"/>
      <Property name="IndexedLookup" id="6953.IndexedLookup" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6953.IndexedLookup.bool"/>
      </Property>
      <Property name="IndexedOpacities" id="6953.IndexedOpacities"/>
      <Property name="NameOfLastPresetApplied" id="6953.NameOfLastPresetApplied" number_of_elements="1">
        <Element index="0" value=""/>
      </Property>
      <Property name="NanColor" id="6953.NanColor" number_of_elements="3">
        <Element index="0" value="0"/>
        <Element index="1" value="1"/>
        <Element index="2" value="0"/>
      </Property>
      <Property name="NanOpacity" id="6953.NanOpacity" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="6953.NanOpacity.range"/>
      </Property>
      <Property name="NumberOfTableValues" id="6953.NumberOfTableValues" number_of_elements="1">
        <Element index="0" value="256"/>
        <Domain name="range" id="6953.NumberOfTableValues.range"/>
      </Property>
      <Property name="RGBPoints" id="6953.RGBPoints" number_of_elements="36">
        <Element index="0" value="9.379468155685795e+31"/>
        <Element index="1" value="0.0564"/>
        <Element index="2" value="0.0564"/>
        <Element index="3" value="0.47"/>
        <Element index="4" value="1.1424474851513062e+45"/>
        <Element index="5" value="0.243"/>
        <Element index="6" value="0.46035"/>
        <Element index="7" value="0.81"/>
        <Element index="8" value="1.9873321150769655e+45"/>
        <Element index="9" value="0.356814"/>
        <Element index="10" value="0.745025"/>
        <Element index="11" value="0.954368"/>
        <Element index="12" value="2.877084533724908e+45"/>
        <Element index="13" value="0.6882"/>
        <Element index="14" value="0.93"/>
        <Element index="15" value="0.91791"/>
        <Element index="16" value="3.328964885167271e+45"/>
        <Element index="17" value="0.899496"/>
        <Element index="18" value="0.944646"/>
        <Element index="19" value="0.768657"/>
        <Element index="20" value="3.91636739708479e+45"/>
        <Element index="21" value="0.957108"/>
        <Element index="22" value="0.833819"/>
        <Element index="23" value="0.508916"/>
        <Element index="24" value="4.701437185953765e+45"/>
        <Element index="25" value="0.927521"/>
        <Element index="26" value="0.621439"/>
        <Element index="27" value="0.315357"/>
        <Element index="28" value="5.6435275905263055e+45"/>
        <Element index="29" value="0.8"/>
        <Element index="30" value="0.352"/>
        <Element index="31" value="0.16"/>
        <Element index="32" value="6.657929770334448e+45"/>
        <Element index="33" value="0.59"/>
        <Element index="34" value="0.0767"/>
        <Element index="35" value="0.119475"/>
      </Property>
      <Property name="RescaleOnVisibilityChange" id="6953.RescaleOnVisibilityChange" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6953.RescaleOnVisibilityChange.bool"/>
      </Property>
      <Property name="ScalarOpacityFunction" id="6953.ScalarOpacityFunction" number_of_elements="1">
        <Proxy value="6951"/>
      </Property>
      <Property name="ScalarRangeInitialized" id="6953.ScalarRangeInitialized" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6953.ScalarRangeInitialized.bool"/>
      </Property>
      <Property name="ShowDataHistogram" id="6953.ShowDataHistogram" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6953.ShowDataHistogram.bool"/>
      </Property>
      <Property name="ShowIndexedColorActiveValues" id="6953.ShowIndexedColorActiveValues" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6953.ShowIndexedColorActiveValues.bool"/>
      </Property>
      <Property name="TransferFunction2D" id="6953.TransferFunction2D" number_of_elements="1">
        <Proxy value="6952"/>
        <Domain name="groups" id="6953.TransferFunction2D.groups"/>
      </Property>
      <Property name="UseAboveRangeColor" id="6953.UseAboveRangeColor" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6953.UseAboveRangeColor.bool"/>
      </Property>
      <Property name="UseBelowRangeColor" id="6953.UseBelowRangeColor" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6953.UseBelowRangeColor.bool"/>
      </Property>
      <Property name="UseLogScale" id="6953.UseLogScale" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6953.UseLogScale.bool"/>
      </Property>
      <Property name="UseOpacityControlPointsFreehandDrawing" id="6953.UseOpacityControlPointsFreehandDrawing" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6953.UseOpacityControlPointsFreehandDrawing.bool"/>
      </Property>
      <Property name="VectorComponent" id="6953.VectorComponent" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="6953.VectorComponent.range"/>
      </Property>
      <Property name="VectorMode" id="6953.VectorMode" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="6953.VectorMode.enum">
          <Entry value="0" text="Magnitude"/>
          <Entry value="1" text="Component"/>
        </Domain>
      </Property>
    </Proxy>
    <Proxy group="materials" type="MaterialLibrary" id="261" servers="21">
      <Property name="LoadMaterials" id="261.LoadMaterials" number_of_elements="1">
        <Element index="0" value=""/>
      </Property>
    </Proxy>
    <Proxy group="piecewise_functions" type="PiecewiseFunction" id="6951" servers="21">
      <Property name="AllowDuplicateScalars" id="6951.AllowDuplicateScalars" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6951.AllowDuplicateScalars.bool"/>
      </Property>
      <Property name="Points" id="6951.Points" number_of_elements="8">
        <Element index="0" value="9.379468155685795e+31"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0.5"/>
        <Element index="3" value="0"/>
        <Element index="4" value="6.657929770334448e+45"/>
        <Element index="5" value="1"/>
        <Element index="6" value="0.5"/>
        <Element index="7" value="0"/>
      </Property>
      <Property name="ScalarRangeInitialized" id="6951.ScalarRangeInitialized" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6951.ScalarRangeInitialized.bool"/>
      </Property>
      <Property name="UseLogScale" id="6951.UseLogScale" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6951.UseLogScale.bool"/>
      </Property>
    </Proxy>
    <Proxy group="annotations" type="GridAxes3DActor" id="317" servers="21">
      <Property name="AxesToLabel" id="317.AxesToLabel" number_of_elements="1">
        <Element index="0" value="63"/>
        <Domain name="range" id="317.AxesToLabel.range"/>
      </Property>
      <Property name="CustomBounds" id="317.CustomBounds" number_of_elements="6">
        <Element index="0" value="0"/>
        <Element index="1" value="1"/>
        <Element index="2" value="0"/>
        <Element index="3" value="1"/>
        <Element index="4" value="0"/>
        <Element index="5" value="1"/>
        <Domain name="range" id="317.CustomBounds.range"/>
      </Property>
      <Property name="DataBoundsScaleFactor" id="317.DataBoundsScaleFactor" number_of_elements="1">
        <Element index="0" value="1.0008"/>
        <Domain name="range" id="317.DataBoundsScaleFactor.range"/>
      </Property>
      <Property name="DataPosition" id="317.DataPosition" number_of_elements="3">
        <Element index="0" value="0"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0"/>
        <Domain name="range" id="317.DataPosition.range"/>
      </Property>
      <Property name="DataScale" id="317.DataScale" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="317.DataScale.range"/>
      </Property>
      <Property name="FacesToRender" id="317.FacesToRender" number_of_elements="1">
        <Element index="0" value="63"/>
        <Domain name="range" id="317.FacesToRender.range"/>
      </Property>
      <Property name="IgnoreDisplayTransformScale" id="317.IgnoreDisplayTransformScale" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="317.IgnoreDisplayTransformScale.bool"/>
      </Property>
      <Property name="LabelUniqueEdgesOnly" id="317.LabelUniqueEdgesOnly" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="317.LabelUniqueEdgesOnly.bool"/>
      </Property>
      <Property name="ModelBounds" id="317.ModelBounds" number_of_elements="6">
        <Element index="0" value="0"/>
        <Element index="1" value="1"/>
        <Element index="2" value="0"/>
        <Element index="3" value="1"/>
        <Element index="4" value="0"/>
        <Element index="5" value="1"/>
      </Property>
      <Property name="ModelTransformMatrix" id="317.ModelTransformMatrix" number_of_elements="16">
        <Element index="0" value="1"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0"/>
        <Element index="3" value="0"/>
        <Element index="4" value="0"/>
        <Element index="5" value="1"/>
        <Element index="6" value="0"/>
        <Element index="7" value="0"/>
        <Element index="8" value="0"/>
        <Element index="9" value="0"/>
        <Element index="10" value="1"/>
        <Element index="11" value="0"/>
        <Element index="12" value="0"/>
        <Element index="13" value="0"/>
        <Element index="14" value="0"/>
        <Element index="15" value="1"/>
      </Property>
      <Property name="ShowEdges" id="317.ShowEdges" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="317.ShowEdges.bool"/>
      </Property>
      <Property name="ShowGrid" id="317.ShowGrid" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="317.ShowGrid.bool"/>
      </Property>
      <Property name="ShowTicks" id="317.ShowTicks" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="317.ShowTicks.bool"/>
      </Property>
      <Property name="UseCustomBounds" id="317.UseCustomBounds" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="317.UseCustomBounds.bool"/>
      </Property>
      <Property name="UseModelTransform" id="317.UseModelTransform" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="317.UseModelTransform.range"/>
      </Property>
      <Property name="Visibility" id="317.Visibility" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="317.Visibility.bool"/>
      </Property>
      <Property name="XAxisLabels" id="317.XAxisLabels">
        <Domain name="scalar_range" id="317.XAxisLabels.scalar_range"/>
      </Property>
      <Property name="XAxisNotation" id="317.XAxisNotation" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="317.XAxisNotation.enum">
          <Entry value="0" text="Mixed"/>
          <Entry value="1" text="Scientific"/>
          <Entry value="2" text="Fixed"/>
        </Domain>
      </Property>
      <Property name="XAxisPrecision" id="317.XAxisPrecision" number_of_elements="1">
        <Element index="0" value="2"/>
        <Domain name="range" id="317.XAxisPrecision.range"/>
      </Property>
      <Property name="XAxisUseCustomLabels" id="317.XAxisUseCustomLabels" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="317.XAxisUseCustomLabels.bool"/>
      </Property>
      <Property name="XTitle" id="317.XTitle" number_of_elements="1">
        <Element index="0" value="X Axis"/>
      </Property>
      <Property name="YAxisLabels" id="317.YAxisLabels">
        <Domain name="scalar_range" id="317.YAxisLabels.scalar_range"/>
      </Property>
      <Property name="YAxisNotation" id="317.YAxisNotation" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="317.YAxisNotation.enum">
          <Entry value="0" text="Mixed"/>
          <Entry value="1" text="Scientific"/>
          <Entry value="2" text="Fixed"/>
        </Domain>
      </Property>
      <Property name="YAxisPrecision" id="317.YAxisPrecision" number_of_elements="1">
        <Element index="0" value="2"/>
        <Domain name="range" id="317.YAxisPrecision.range"/>
      </Property>
      <Property name="YAxisUseCustomLabels" id="317.YAxisUseCustomLabels" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="317.YAxisUseCustomLabels.bool"/>
      </Property>
      <Property name="YTitle" id="317.YTitle" number_of_elements="1">
        <Element index="0" value="Y Axis"/>
      </Property>
      <Property name="ZAxisLabels" id="317.ZAxisLabels">
        <Domain name="scalar_range" id="317.ZAxisLabels.scalar_range"/>
      </Property>
      <Property name="ZAxisNotation" id="317.ZAxisNotation" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="317.ZAxisNotation.enum">
          <Entry value="0" text="Mixed"/>
          <Entry value="1" text="Scientific"/>
          <Entry value="2" text="Fixed"/>
        </Domain>
      </Property>
      <Property name="ZAxisPrecision" id="317.ZAxisPrecision" number_of_elements="1">
        <Element index="0" value="2"/>
        <Domain name="range" id="317.ZAxisPrecision.range"/>
      </Property>
      <Property name="ZAxisUseCustomLabels" id="317.ZAxisUseCustomLabels" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="317.ZAxisUseCustomLabels.bool"/>
      </Property>
      <Property name="ZTitle" id="317.ZTitle" number_of_elements="1">
        <Element index="0" value="Z Axis"/>
      </Property>
      <Property name="CullBackface" id="317.CullBackface" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="317.CullBackface.bool"/>
      </Property>
      <Property name="CullFrontface" id="317.CullFrontface" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="317.CullFrontface.bool"/>
      </Property>
      <Property name="GridColor" id="317.GridColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="317.GridColor.range"/>
      </Property>
      <Property name="XLabelBold" id="317.XLabelBold" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="317.XLabelBold.bool"/>
      </Property>
      <Property name="XLabelColor" id="317.XLabelColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="317.XLabelColor.range"/>
      </Property>
      <Property name="XLabelFontFamily" id="317.XLabelFontFamily" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="317.XLabelFontFamily.enum">
          <Entry value="0" text="Arial"/>
          <Entry value="1" text="Courier"/>
          <Entry value="2" text="Times"/>
          <Entry value="4" text="File"/>
        </Domain>
      </Property>
      <Property name="XLabelFontFile" id="317.XLabelFontFile" number_of_elements="1">
        <Element index="0" value=""/>
      </Property>
      <Property name="XLabelFontSize" id="317.XLabelFontSize" number_of_elements="1">
        <Element index="0" value="12"/>
        <Domain name="range" id="317.XLabelFontSize.range"/>
      </Property>
      <Property name="XLabelItalic" id="317.XLabelItalic" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="317.XLabelItalic.bool"/>
      </Property>
      <Property name="XLabelOpacity" id="317.XLabelOpacity" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="317.XLabelOpacity.range"/>
      </Property>
      <Property name="XLabelShadow" id="317.XLabelShadow" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="317.XLabelShadow.bool"/>
      </Property>
      <Property name="XTitleBold" id="317.XTitleBold" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="317.XTitleBold.bool"/>
      </Property>
      <Property name="XTitleColor" id="317.XTitleColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="317.XTitleColor.range"/>
      </Property>
      <Property name="XTitleFontFamily" id="317.XTitleFontFamily" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="317.XTitleFontFamily.enum">
          <Entry value="0" text="Arial"/>
          <Entry value="1" text="Courier"/>
          <Entry value="2" text="Times"/>
          <Entry value="4" text="File"/>
        </Domain>
      </Property>
      <Property name="XTitleFontFile" id="317.XTitleFontFile" number_of_elements="1">
        <Element index="0" value=""/>
      </Property>
      <Property name="XTitleFontSize" id="317.XTitleFontSize" number_of_elements="1">
        <Element index="0" value="12"/>
        <Domain name="range" id="317.XTitleFontSize.range"/>
      </Property>
      <Property name="XTitleItalic" id="317.XTitleItalic" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="317.XTitleItalic.bool"/>
      </Property>
      <Property name="XTitleOpacity" id="317.XTitleOpacity" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="317.XTitleOpacity.range"/>
      </Property>
      <Property name="XTitleShadow" id="317.XTitleShadow" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="317.XTitleShadow.bool"/>
      </Property>
      <Property name="YLabelBold" id="317.YLabelBold" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="317.YLabelBold.bool"/>
      </Property>
      <Property name="YLabelColor" id="317.YLabelColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="317.YLabelColor.range"/>
      </Property>
      <Property name="YLabelFontFamily" id="317.YLabelFontFamily" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="317.YLabelFontFamily.enum">
          <Entry value="0" text="Arial"/>
          <Entry value="1" text="Courier"/>
          <Entry value="2" text="Times"/>
          <Entry value="4" text="File"/>
        </Domain>
      </Property>
      <Property name="YLabelFontFile" id="317.YLabelFontFile" number_of_elements="1">
        <Element index="0" value=""/>
      </Property>
      <Property name="YLabelFontSize" id="317.YLabelFontSize" number_of_elements="1">
        <Element index="0" value="12"/>
        <Domain name="range" id="317.YLabelFontSize.range"/>
      </Property>
      <Property name="YLabelItalic" id="317.YLabelItalic" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="317.YLabelItalic.bool"/>
      </Property>
      <Property name="YLabelOpacity" id="317.YLabelOpacity" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="317.YLabelOpacity.range"/>
      </Property>
      <Property name="YLabelShadow" id="317.YLabelShadow" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="317.YLabelShadow.bool"/>
      </Property>
      <Property name="YTitleBold" id="317.YTitleBold" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="317.YTitleBold.bool"/>
      </Property>
      <Property name="YTitleColor" id="317.YTitleColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="317.YTitleColor.range"/>
      </Property>
      <Property name="YTitleFontFamily" id="317.YTitleFontFamily" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="317.YTitleFontFamily.enum">
          <Entry value="0" text="Arial"/>
          <Entry value="1" text="Courier"/>
          <Entry value="2" text="Times"/>
          <Entry value="4" text="File"/>
        </Domain>
      </Property>
      <Property name="YTitleFontFile" id="317.YTitleFontFile" number_of_elements="1">
        <Element index="0" value=""/>
      </Property>
      <Property name="YTitleFontSize" id="317.YTitleFontSize" number_of_elements="1">
        <Element index="0" value="12"/>
        <Domain name="range" id="317.YTitleFontSize.range"/>
      </Property>
      <Property name="YTitleItalic" id="317.YTitleItalic" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="317.YTitleItalic.bool"/>
      </Property>
      <Property name="YTitleOpacity" id="317.YTitleOpacity" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="317.YTitleOpacity.range"/>
      </Property>
      <Property name="YTitleShadow" id="317.YTitleShadow" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="317.YTitleShadow.bool"/>
      </Property>
      <Property name="ZLabelBold" id="317.ZLabelBold" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="317.ZLabelBold.bool"/>
      </Property>
      <Property name="ZLabelColor" id="317.ZLabelColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="317.ZLabelColor.range"/>
      </Property>
      <Property name="ZLabelFontFamily" id="317.ZLabelFontFamily" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="317.ZLabelFontFamily.enum">
          <Entry value="0" text="Arial"/>
          <Entry value="1" text="Courier"/>
          <Entry value="2" text="Times"/>
          <Entry value="4" text="File"/>
        </Domain>
      </Property>
      <Property name="ZLabelFontFile" id="317.ZLabelFontFile" number_of_elements="1">
        <Element index="0" value=""/>
      </Property>
      <Property name="ZLabelFontSize" id="317.ZLabelFontSize" number_of_elements="1">
        <Element index="0" value="12"/>
        <Domain name="range" id="317.ZLabelFontSize.range"/>
      </Property>
      <Property name="ZLabelItalic" id="317.ZLabelItalic" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="317.ZLabelItalic.bool"/>
      </Property>
      <Property name="ZLabelOpacity" id="317.ZLabelOpacity" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="317.ZLabelOpacity.range"/>
      </Property>
      <Property name="ZLabelShadow" id="317.ZLabelShadow" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="317.ZLabelShadow.bool"/>
      </Property>
      <Property name="ZTitleBold" id="317.ZTitleBold" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="317.ZTitleBold.bool"/>
      </Property>
      <Property name="ZTitleColor" id="317.ZTitleColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="317.ZTitleColor.range"/>
      </Property>
      <Property name="ZTitleFontFamily" id="317.ZTitleFontFamily" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="317.ZTitleFontFamily.enum">
          <Entry value="0" text="Arial"/>
          <Entry value="1" text="Courier"/>
          <Entry value="2" text="Times"/>
          <Entry value="4" text="File"/>
        </Domain>
      </Property>
      <Property name="ZTitleFontFile" id="317.ZTitleFontFile" number_of_elements="1">
        <Element index="0" value=""/>
      </Property>
      <Property name="ZTitleFontSize" id="317.ZTitleFontSize" number_of_elements="1">
        <Element index="0" value="12"/>
        <Domain name="range" id="317.ZTitleFontSize.range"/>
      </Property>
      <Property name="ZTitleItalic" id="317.ZTitleItalic" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="317.ZTitleItalic.bool"/>
      </Property>
      <Property name="ZTitleOpacity" id="317.ZTitleOpacity" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="317.ZTitleOpacity.range"/>
      </Property>
      <Property name="ZTitleShadow" id="317.ZTitleShadow" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="317.ZTitleShadow.bool"/>
      </Property>
    </Proxy>
    <Proxy group="annotations" type="LegendGridActor" id="320" servers="21">
      <Property name="AxisNotation" id="320.AxisNotation" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="320.AxisNotation.enum">
          <Entry value="0" text="Default"/>
          <Entry value="1" text="Scientific"/>
          <Entry value="2" text="Fixed"/>
        </Domain>
      </Property>
      <Property name="AxisPrecision" id="320.AxisPrecision" number_of_elements="1">
        <Element index="0" value="2"/>
        <Domain name="range" id="320.AxisPrecision.range"/>
      </Property>
      <Property name="BottomBorderOffset" id="320.BottomBorderOffset" number_of_elements="1">
        <Element index="0" value="30"/>
        <Domain name="range" id="320.BottomBorderOffset.range"/>
      </Property>
      <Property name="GridVisibility" id="320.GridVisibility" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="320.GridVisibility.bool"/>
      </Property>
      <Property name="HorizontalLabelNumber" id="320.HorizontalLabelNumber" number_of_elements="1">
        <Element index="0" value="5"/>
        <Domain name="range" id="320.HorizontalLabelNumber.range"/>
      </Property>
      <Property name="LeftBorderOffset" id="320.LeftBorderOffset" number_of_elements="1">
        <Element index="0" value="50"/>
        <Domain name="range" id="320.LeftBorderOffset.range"/>
      </Property>
      <Property name="Origin" id="320.Origin" number_of_elements="3">
        <Element index="0" value="0"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0"/>
      </Property>
      <Property name="RightBorderOffset" id="320.RightBorderOffset" number_of_elements="1">
        <Element index="0" value="50"/>
        <Domain name="range" id="320.RightBorderOffset.range"/>
      </Property>
      <Property name="TopBorderOffset" id="320.TopBorderOffset" number_of_elements="1">
        <Element index="0" value="30"/>
        <Domain name="range" id="320.TopBorderOffset.range"/>
      </Property>
      <Property name="VerticalLabelNumber" id="320.VerticalLabelNumber" number_of_elements="1">
        <Element index="0" value="5"/>
        <Domain name="range" id="320.VerticalLabelNumber.range"/>
      </Property>
      <Property name="Visibility" id="320.Visibility" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="320.Visibility.bool"/>
      </Property>
      <Property name="GridColor" id="320.GridColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="320.GridColor.range"/>
      </Property>
      <Property name="LegendLabelBold" id="320.LegendLabelBold" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="320.LegendLabelBold.bool"/>
      </Property>
      <Property name="LegendLabelColor" id="320.LegendLabelColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="320.LegendLabelColor.range"/>
      </Property>
      <Property name="LegendLabelFontFamily" id="320.LegendLabelFontFamily" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="320.LegendLabelFontFamily.enum">
          <Entry value="0" text="Arial"/>
          <Entry value="1" text="Courier"/>
          <Entry value="2" text="Times"/>
          <Entry value="4" text="File"/>
        </Domain>
      </Property>
      <Property name="LegendLabelFontFile" id="320.LegendLabelFontFile" number_of_elements="1">
        <Element index="0" value=""/>
      </Property>
      <Property name="LegendLabelFontSize" id="320.LegendLabelFontSize" number_of_elements="1">
        <Element index="0" value="12"/>
        <Domain name="range" id="320.LegendLabelFontSize.range"/>
      </Property>
      <Property name="LegendLabelItalic" id="320.LegendLabelItalic" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="320.LegendLabelItalic.bool"/>
      </Property>
      <Property name="LegendLabelOpacity" id="320.LegendLabelOpacity" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="320.LegendLabelOpacity.range"/>
      </Property>
      <Property name="LegendLabelShadow" id="320.LegendLabelShadow" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="320.LegendLabelShadow.bool"/>
      </Property>
    </Proxy>
    <Proxy group="annotations" type="PolarGridActor" id="323" servers="21">
      <Property name="AxesLength" id="323.AxesLength" number_of_elements="1">
        <Element index="0" value="100"/>
        <Domain name="range" id="323.AxesLength.range"/>
      </Property>
      <Property name="EndAngle" id="323.EndAngle" number_of_elements="1">
        <Element index="0" value="180"/>
        <Domain name="range" id="323.EndAngle.range"/>
      </Property>
      <Property name="NumberOfAxes" id="323.NumberOfAxes" number_of_elements="1">
        <Element index="0" value="6"/>
        <Domain name="range" id="323.NumberOfAxes.range"/>
      </Property>
      <Property name="NumberOfTicks" id="323.NumberOfTicks" number_of_elements="1">
        <Element index="0" value="6"/>
        <Domain name="range" id="323.NumberOfTicks.range"/>
      </Property>
      <Property name="Origin" id="323.Origin" number_of_elements="2">
        <Element index="0" value="0.5"/>
        <Element index="1" value="0.5"/>
        <Domain name="range" id="323.Origin.range"/>
      </Property>
      <Property name="StartAngle" id="323.StartAngle" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="323.StartAngle.range"/>
      </Property>
      <Property name="Visibility" id="323.Visibility" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="323.Visibility.bool"/>
      </Property>
      <Property name="AxesLabelBold" id="323.AxesLabelBold" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="323.AxesLabelBold.bool"/>
      </Property>
      <Property name="AxesLabelColor" id="323.AxesLabelColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="323.AxesLabelColor.range"/>
      </Property>
      <Property name="AxesLabelFontFamily" id="323.AxesLabelFontFamily" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="323.AxesLabelFontFamily.enum">
          <Entry value="0" text="Arial"/>
          <Entry value="1" text="Courier"/>
          <Entry value="2" text="Times"/>
          <Entry value="4" text="File"/>
        </Domain>
      </Property>
      <Property name="AxesLabelFontSize" id="323.AxesLabelFontSize" number_of_elements="1">
        <Element index="0" value="12"/>
        <Domain name="range" id="323.AxesLabelFontSize.range"/>
      </Property>
      <Property name="AxesLabelItalic" id="323.AxesLabelItalic" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="323.AxesLabelItalic.bool"/>
      </Property>
      <Property name="AxesLabelShadow" id="323.AxesLabelShadow" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="323.AxesLabelShadow.bool"/>
      </Property>
      <Property name="GridColor" id="323.GridColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="323.GridColor.range"/>
      </Property>
    </Proxy>
    <Proxy group="misc" type="RepresentationAnimationHelper" id="6589" servers="16">
      <Property name="Source" id="6589.Source" number_of_elements="1">
        <Proxy value="6577"/>
      </Property>
    </Proxy>
    <Proxy group="representations" type="GridAxesRepresentation" id="6697" servers="21">
      <Property name="GridAxesVisibility" id="6697.GridAxesVisibility" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6697.GridAxesVisibility.bool"/>
      </Property>
      <Property name="Input" id="6697.Input">
        <Domain name="input_array_any" id="6697.Input.input_array_any"/>
      </Property>
      <Property name="Position" id="6697.Position" number_of_elements="3">
        <Element index="0" value="0"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0"/>
        <Domain name="range" id="6697.Position.range"/>
      </Property>
      <Property name="Scale" id="6697.Scale" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="6697.Scale.range"/>
      </Property>
      <Property name="AxesToLabel" id="6697.AxesToLabel" number_of_elements="1">
        <Element index="0" value="63"/>
        <Domain name="range" id="6697.AxesToLabel.range"/>
      </Property>
      <Property name="CullBackface" id="6697.CullBackface" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6697.CullBackface.bool"/>
      </Property>
      <Property name="CullFrontface" id="6697.CullFrontface" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6697.CullFrontface.bool"/>
      </Property>
      <Property name="CustomBounds" id="6697.CustomBounds" number_of_elements="6">
        <Element index="0" value="0"/>
        <Element index="1" value="1"/>
        <Element index="2" value="0"/>
        <Element index="3" value="1"/>
        <Element index="4" value="0"/>
        <Element index="5" value="1"/>
        <Domain name="range" id="6697.CustomBounds.range"/>
      </Property>
      <Property name="FacesToRender" id="6697.FacesToRender" number_of_elements="1">
        <Element index="0" value="63"/>
        <Domain name="range" id="6697.FacesToRender.range"/>
      </Property>
      <Property name="GridColor" id="6697.GridColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="6697.GridColor.range"/>
      </Property>
      <Property name="IgnoreDisplayTransformScale" id="6697.IgnoreDisplayTransformScale" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6697.IgnoreDisplayTransformScale.bool"/>
      </Property>
      <Property name="LabelUniqueEdgesOnly" id="6697.LabelUniqueEdgesOnly" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6697.LabelUniqueEdgesOnly.bool"/>
      </Property>
      <Property name="ShowEdges" id="6697.ShowEdges" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6697.ShowEdges.bool"/>
      </Property>
      <Property name="ShowGrid" id="6697.ShowGrid" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6697.ShowGrid.bool"/>
      </Property>
      <Property name="ShowTicks" id="6697.ShowTicks" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6697.ShowTicks.bool"/>
      </Property>
      <Property name="UseCustomBounds" id="6697.UseCustomBounds" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6697.UseCustomBounds.bool"/>
      </Property>
      <Property name="XAxisLabels" id="6697.XAxisLabels">
        <Domain name="scalar_range" id="6697.XAxisLabels.scalar_range"/>
      </Property>
      <Property name="XAxisNotation" id="6697.XAxisNotation" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="6697.XAxisNotation.enum">
          <Entry value="0" text="Mixed"/>
          <Entry value="1" text="Scientific"/>
          <Entry value="2" text="Fixed"/>
        </Domain>
      </Property>
      <Property name="XAxisPrecision" id="6697.XAxisPrecision" number_of_elements="1">
        <Element index="0" value="2"/>
        <Domain name="range" id="6697.XAxisPrecision.range"/>
      </Property>
      <Property name="XAxisUseCustomLabels" id="6697.XAxisUseCustomLabels" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6697.XAxisUseCustomLabels.bool"/>
      </Property>
      <Property name="XLabelBold" id="6697.XLabelBold" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6697.XLabelBold.bool"/>
      </Property>
      <Property name="XLabelColor" id="6697.XLabelColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="6697.XLabelColor.range"/>
      </Property>
      <Property name="XLabelFontFamily" id="6697.XLabelFontFamily" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="6697.XLabelFontFamily.enum">
          <Entry value="0" text="Arial"/>
          <Entry value="1" text="Courier"/>
          <Entry value="2" text="Times"/>
          <Entry value="4" text="File"/>
        </Domain>
      </Property>
      <Property name="XLabelFontFile" id="6697.XLabelFontFile" number_of_elements="1">
        <Element index="0" value=""/>
      </Property>
      <Property name="XLabelFontSize" id="6697.XLabelFontSize" number_of_elements="1">
        <Element index="0" value="12"/>
        <Domain name="range" id="6697.XLabelFontSize.range"/>
      </Property>
      <Property name="XLabelItalic" id="6697.XLabelItalic" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6697.XLabelItalic.bool"/>
      </Property>
      <Property name="XLabelOpacity" id="6697.XLabelOpacity" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="6697.XLabelOpacity.range"/>
      </Property>
      <Property name="XLabelShadow" id="6697.XLabelShadow" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6697.XLabelShadow.bool"/>
      </Property>
      <Property name="XTitle" id="6697.XTitle" number_of_elements="1">
        <Element index="0" value="X Axis"/>
      </Property>
      <Property name="XTitleBold" id="6697.XTitleBold" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6697.XTitleBold.bool"/>
      </Property>
      <Property name="XTitleColor" id="6697.XTitleColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="6697.XTitleColor.range"/>
      </Property>
      <Property name="XTitleFontFamily" id="6697.XTitleFontFamily" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="6697.XTitleFontFamily.enum">
          <Entry value="0" text="Arial"/>
          <Entry value="1" text="Courier"/>
          <Entry value="2" text="Times"/>
          <Entry value="4" text="File"/>
        </Domain>
      </Property>
      <Property name="XTitleFontFile" id="6697.XTitleFontFile" number_of_elements="1">
        <Element index="0" value=""/>
      </Property>
      <Property name="XTitleFontSize" id="6697.XTitleFontSize" number_of_elements="1">
        <Element index="0" value="12"/>
        <Domain name="range" id="6697.XTitleFontSize.range"/>
      </Property>
      <Property name="XTitleItalic" id="6697.XTitleItalic" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6697.XTitleItalic.bool"/>
      </Property>
      <Property name="XTitleOpacity" id="6697.XTitleOpacity" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="6697.XTitleOpacity.range"/>
      </Property>
      <Property name="XTitleShadow" id="6697.XTitleShadow" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6697.XTitleShadow.bool"/>
      </Property>
      <Property name="YAxisLabels" id="6697.YAxisLabels">
        <Domain name="scalar_range" id="6697.YAxisLabels.scalar_range"/>
      </Property>
      <Property name="YAxisNotation" id="6697.YAxisNotation" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="6697.YAxisNotation.enum">
          <Entry value="0" text="Mixed"/>
          <Entry value="1" text="Scientific"/>
          <Entry value="2" text="Fixed"/>
        </Domain>
      </Property>
      <Property name="YAxisPrecision" id="6697.YAxisPrecision" number_of_elements="1">
        <Element index="0" value="2"/>
        <Domain name="range" id="6697.YAxisPrecision.range"/>
      </Property>
      <Property name="YAxisUseCustomLabels" id="6697.YAxisUseCustomLabels" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6697.YAxisUseCustomLabels.bool"/>
      </Property>
      <Property name="YLabelBold" id="6697.YLabelBold" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6697.YLabelBold.bool"/>
      </Property>
      <Property name="YLabelColor" id="6697.YLabelColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="6697.YLabelColor.range"/>
      </Property>
      <Property name="YLabelFontFamily" id="6697.YLabelFontFamily" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="6697.YLabelFontFamily.enum">
          <Entry value="0" text="Arial"/>
          <Entry value="1" text="Courier"/>
          <Entry value="2" text="Times"/>
          <Entry value="4" text="File"/>
        </Domain>
      </Property>
      <Property name="YLabelFontFile" id="6697.YLabelFontFile" number_of_elements="1">
        <Element index="0" value=""/>
      </Property>
      <Property name="YLabelFontSize" id="6697.YLabelFontSize" number_of_elements="1">
        <Element index="0" value="12"/>
        <Domain name="range" id="6697.YLabelFontSize.range"/>
      </Property>
      <Property name="YLabelItalic" id="6697.YLabelItalic" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6697.YLabelItalic.bool"/>
      </Property>
      <Property name="YLabelOpacity" id="6697.YLabelOpacity" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="6697.YLabelOpacity.range"/>
      </Property>
      <Property name="YLabelShadow" id="6697.YLabelShadow" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6697.YLabelShadow.bool"/>
      </Property>
      <Property name="YTitle" id="6697.YTitle" number_of_elements="1">
        <Element index="0" value="Y Axis"/>
      </Property>
      <Property name="YTitleBold" id="6697.YTitleBold" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6697.YTitleBold.bool"/>
      </Property>
      <Property name="YTitleColor" id="6697.YTitleColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="6697.YTitleColor.range"/>
      </Property>
      <Property name="YTitleFontFamily" id="6697.YTitleFontFamily" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="6697.YTitleFontFamily.enum">
          <Entry value="0" text="Arial"/>
          <Entry value="1" text="Courier"/>
          <Entry value="2" text="Times"/>
          <Entry value="4" text="File"/>
        </Domain>
      </Property>
      <Property name="YTitleFontFile" id="6697.YTitleFontFile" number_of_elements="1">
        <Element index="0" value=""/>
      </Property>
      <Property name="YTitleFontSize" id="6697.YTitleFontSize" number_of_elements="1">
        <Element index="0" value="12"/>
        <Domain name="range" id="6697.YTitleFontSize.range"/>
      </Property>
      <Property name="YTitleItalic" id="6697.YTitleItalic" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6697.YTitleItalic.bool"/>
      </Property>
      <Property name="YTitleOpacity" id="6697.YTitleOpacity" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="6697.YTitleOpacity.range"/>
      </Property>
      <Property name="YTitleShadow" id="6697.YTitleShadow" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6697.YTitleShadow.bool"/>
      </Property>
      <Property name="ZAxisLabels" id="6697.ZAxisLabels">
        <Domain name="scalar_range" id="6697.ZAxisLabels.scalar_range"/>
      </Property>
      <Property name="ZAxisNotation" id="6697.ZAxisNotation" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="6697.ZAxisNotation.enum">
          <Entry value="0" text="Mixed"/>
          <Entry value="1" text="Scientific"/>
          <Entry value="2" text="Fixed"/>
        </Domain>
      </Property>
      <Property name="ZAxisPrecision" id="6697.ZAxisPrecision" number_of_elements="1">
        <Element index="0" value="2"/>
        <Domain name="range" id="6697.ZAxisPrecision.range"/>
      </Property>
      <Property name="ZAxisUseCustomLabels" id="6697.ZAxisUseCustomLabels" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6697.ZAxisUseCustomLabels.bool"/>
      </Property>
      <Property name="ZLabelBold" id="6697.ZLabelBold" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6697.ZLabelBold.bool"/>
      </Property>
      <Property name="ZLabelColor" id="6697.ZLabelColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="6697.ZLabelColor.range"/>
      </Property>
      <Property name="ZLabelFontFamily" id="6697.ZLabelFontFamily" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="6697.ZLabelFontFamily.enum">
          <Entry value="0" text="Arial"/>
          <Entry value="1" text="Courier"/>
          <Entry value="2" text="Times"/>
          <Entry value="4" text="File"/>
        </Domain>
      </Property>
      <Property name="ZLabelFontFile" id="6697.ZLabelFontFile" number_of_elements="1">
        <Element index="0" value=""/>
      </Property>
      <Property name="ZLabelFontSize" id="6697.ZLabelFontSize" number_of_elements="1">
        <Element index="0" value="12"/>
        <Domain name="range" id="6697.ZLabelFontSize.range"/>
      </Property>
      <Property name="ZLabelItalic" id="6697.ZLabelItalic" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6697.ZLabelItalic.bool"/>
      </Property>
      <Property name="ZLabelOpacity" id="6697.ZLabelOpacity" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="6697.ZLabelOpacity.range"/>
      </Property>
      <Property name="ZLabelShadow" id="6697.ZLabelShadow" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6697.ZLabelShadow.bool"/>
      </Property>
      <Property name="ZTitle" id="6697.ZTitle" number_of_elements="1">
        <Element index="0" value="Z Axis"/>
      </Property>
      <Property name="ZTitleBold" id="6697.ZTitleBold" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6697.ZTitleBold.bool"/>
      </Property>
      <Property name="ZTitleColor" id="6697.ZTitleColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="6697.ZTitleColor.range"/>
      </Property>
      <Property name="ZTitleFontFamily" id="6697.ZTitleFontFamily" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="6697.ZTitleFontFamily.enum">
          <Entry value="0" text="Arial"/>
          <Entry value="1" text="Courier"/>
          <Entry value="2" text="Times"/>
          <Entry value="4" text="File"/>
        </Domain>
      </Property>
      <Property name="ZTitleFontFile" id="6697.ZTitleFontFile" number_of_elements="1">
        <Element index="0" value=""/>
      </Property>
      <Property name="ZTitleFontSize" id="6697.ZTitleFontSize" number_of_elements="1">
        <Element index="0" value="12"/>
        <Domain name="range" id="6697.ZTitleFontSize.range"/>
      </Property>
      <Property name="ZTitleItalic" id="6697.ZTitleItalic" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6697.ZTitleItalic.bool"/>
      </Property>
      <Property name="ZTitleOpacity" id="6697.ZTitleOpacity" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="6697.ZTitleOpacity.range"/>
      </Property>
      <Property name="ZTitleShadow" id="6697.ZTitleShadow" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6697.ZTitleShadow.bool"/>
      </Property>
    </Proxy>
    <Proxy group="sources" type="ArrowSource" id="6734" servers="21">
      <Property name="Invert" id="6734.Invert" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6734.Invert.bool"/>
      </Property>
      <Property name="ShaftRadius" id="6734.ShaftRadius" number_of_elements="1">
        <Element index="0" value="0.03"/>
        <Domain name="range" id="6734.ShaftRadius.range"/>
      </Property>
      <Property name="ShaftResolution" id="6734.ShaftResolution" number_of_elements="1">
        <Element index="0" value="6"/>
        <Domain name="range" id="6734.ShaftResolution.range"/>
      </Property>
      <Property name="TipLength" id="6734.TipLength" number_of_elements="1">
        <Element index="0" value="0.35"/>
        <Domain name="range" id="6734.TipLength.range"/>
      </Property>
      <Property name="TipRadius" id="6734.TipRadius" number_of_elements="1">
        <Element index="0" value="0.1"/>
        <Domain name="range" id="6734.TipRadius.range"/>
      </Property>
      <Property name="TipResolution" id="6734.TipResolution" number_of_elements="1">
        <Element index="0" value="6"/>
        <Domain name="range" id="6734.TipResolution.range"/>
      </Property>
    </Proxy>
    <Proxy group="sources" type="ConeSource" id="6745" servers="21">
      <Property name="Capping" id="6745.Capping" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6745.Capping.bool"/>
      </Property>
      <Property name="Center" id="6745.Center" number_of_elements="3">
        <Element index="0" value="0"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0"/>
        <Domain name="range" id="6745.Center.range"/>
      </Property>
      <Property name="Direction" id="6745.Direction" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0"/>
        <Domain name="range" id="6745.Direction.range"/>
      </Property>
      <Property name="Height" id="6745.Height" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="6745.Height.range"/>
      </Property>
      <Property name="Radius" id="6745.Radius" number_of_elements="1">
        <Element index="0" value="0.5"/>
        <Domain name="range" id="6745.Radius.range"/>
      </Property>
      <Property name="Resolution" id="6745.Resolution" number_of_elements="1">
        <Element index="0" value="6"/>
        <Domain name="range" id="6745.Resolution.range"/>
      </Property>
    </Proxy>
    <Proxy group="sources" type="CubeSource" id="6756" servers="21">
      <Property name="Center" id="6756.Center" number_of_elements="3">
        <Element index="0" value="0"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0"/>
        <Domain name="range" id="6756.Center.range"/>
      </Property>
      <Property name="XLength" id="6756.XLength" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="6756.XLength.range"/>
      </Property>
      <Property name="YLength" id="6756.YLength" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="6756.YLength.range"/>
      </Property>
      <Property name="ZLength" id="6756.ZLength" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="6756.ZLength.range"/>
      </Property>
    </Proxy>
    <Proxy group="sources" type="CylinderSource" id="6767" servers="21">
      <Property name="Capping" id="6767.Capping" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6767.Capping.bool"/>
      </Property>
      <Property name="Center" id="6767.Center" number_of_elements="3">
        <Element index="0" value="0"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0"/>
        <Domain name="range" id="6767.Center.range"/>
      </Property>
      <Property name="Height" id="6767.Height" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="6767.Height.range"/>
      </Property>
      <Property name="Radius" id="6767.Radius" number_of_elements="1">
        <Element index="0" value="0.5"/>
        <Domain name="range" id="6767.Radius.range"/>
      </Property>
      <Property name="Resolution" id="6767.Resolution" number_of_elements="1">
        <Element index="0" value="6"/>
        <Domain name="range" id="6767.Resolution.range"/>
      </Property>
    </Proxy>
    <Proxy group="sources" type="LineSource" id="6778" servers="21">
      <Property name="Point1" id="6778.Point1" number_of_elements="3">
        <Element index="0" value="-0.5"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0"/>
        <Domain name="range" id="6778.Point1.range"/>
      </Property>
      <Property name="Point2" id="6778.Point2" number_of_elements="3">
        <Element index="0" value="0.5"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0"/>
        <Domain name="range" id="6778.Point2.range"/>
      </Property>
      <Property name="RefinementRatios" id="6778.RefinementRatios" number_of_elements="2">
        <Element index="0" value="0"/>
        <Element index="1" value="1"/>
        <Domain name="range" id="6778.RefinementRatios.range"/>
      </Property>
      <Property name="Resolution" id="6778.Resolution" number_of_elements="1">
        <Element index="0" value="6"/>
        <Domain name="range" id="6778.Resolution.range"/>
      </Property>
      <Property name="UseRegularRefinement" id="6778.UseRegularRefinement" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6778.UseRegularRefinement.bool"/>
      </Property>
    </Proxy>
    <Proxy group="sources" type="SphereSource" id="6789" servers="21">
      <Property name="Center" id="6789.Center" number_of_elements="3">
        <Element index="0" value="0"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0"/>
        <Domain name="range" id="6789.Center.range"/>
      </Property>
      <Property name="EndPhi" id="6789.EndPhi" number_of_elements="1">
        <Element index="0" value="180"/>
        <Domain name="range" id="6789.EndPhi.range"/>
      </Property>
      <Property name="EndTheta" id="6789.EndTheta" number_of_elements="1">
        <Element index="0" value="360"/>
        <Domain name="range" id="6789.EndTheta.range"/>
      </Property>
      <Property name="PhiResolution" id="6789.PhiResolution" number_of_elements="1">
        <Element index="0" value="8"/>
        <Domain name="range" id="6789.PhiResolution.range"/>
      </Property>
      <Property name="Radius" id="6789.Radius" number_of_elements="1">
        <Element index="0" value="0.5"/>
        <Domain name="range" id="6789.Radius.range"/>
      </Property>
      <Property name="StartPhi" id="6789.StartPhi" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="6789.StartPhi.range"/>
      </Property>
      <Property name="StartTheta" id="6789.StartTheta" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="6789.StartTheta.range"/>
      </Property>
      <Property name="ThetaResolution" id="6789.ThetaResolution" number_of_elements="1">
        <Element index="0" value="8"/>
        <Domain name="range" id="6789.ThetaResolution.range"/>
      </Property>
    </Proxy>
    <Proxy group="sources" type="GlyphSource2D" id="6800" servers="21">
      <Property name="Center" id="6800.Center" number_of_elements="3">
        <Element index="0" value="0"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0"/>
        <Domain name="range" id="6800.Center.range"/>
      </Property>
      <Property name="DoublePointed" id="6800.DoublePointed" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6800.DoublePointed.bool"/>
      </Property>
      <Property name="Filled" id="6800.Filled" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6800.Filled.bool"/>
      </Property>
      <Property name="GlyphType" id="6800.GlyphType" number_of_elements="1">
        <Element index="0" value="9"/>
        <Domain name="enum" id="6800.GlyphType.enum">
          <Entry value="1" text="Vertex"/>
          <Entry value="2" text="Dash"/>
          <Entry value="3" text="Cross"/>
          <Entry value="4" text="ThickCross"/>
          <Entry value="5" text="Triangle"/>
          <Entry value="6" text="Square"/>
          <Entry value="7" text="Circle"/>
          <Entry value="8" text="Diamond"/>
          <Entry value="9" text="Arrow"/>
          <Entry value="10" text="ThickArrow"/>
          <Entry value="11" text="HookedArrow"/>
          <Entry value="12" text="EdgeArrow"/>
        </Domain>
      </Property>
      <Property name="PointInwards" id="6800.PointInwards" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6800.PointInwards.bool"/>
      </Property>
      <Property name="TipLength" id="6800.TipLength" number_of_elements="1">
        <Element index="0" value="0.3"/>
        <Domain name="range" id="6800.TipLength.range"/>
      </Property>
    </Proxy>
    <Proxy group="internal_filters" type="PipelineConnection" id="6811" servers="21">
      <Property name="AllowNullInput" id="6811.AllowNullInput" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6811.AllowNullInput.bool"/>
      </Property>
      <Property name="Input" id="6811.Input">
        <Domain name="groups" id="6811.Input.groups"/>
        <Domain name="input_type" id="6811.Input.input_type"/>
      </Property>
    </Proxy>
    <Proxy group="piecewise_functions" type="PiecewiseFunction" id="6890" servers="21">
      <Property name="AllowDuplicateScalars" id="6890.AllowDuplicateScalars" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6890.AllowDuplicateScalars.bool"/>
      </Property>
      <Property name="Points" id="6890.Points" number_of_elements="8">
        <Element index="0" value="0"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0.5"/>
        <Element index="3" value="0"/>
        <Element index="4" value="1"/>
        <Element index="5" value="1"/>
        <Element index="6" value="0.5"/>
        <Element index="7" value="0"/>
      </Property>
      <Property name="ScalarRangeInitialized" id="6890.ScalarRangeInitialized" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6890.ScalarRangeInitialized.bool"/>
      </Property>
      <Property name="UseLogScale" id="6890.UseLogScale" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6890.UseLogScale.bool"/>
      </Property>
    </Proxy>
    <Proxy group="piecewise_functions" type="PiecewiseFunction" id="6844" servers="21">
      <Property name="AllowDuplicateScalars" id="6844.AllowDuplicateScalars" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6844.AllowDuplicateScalars.bool"/>
      </Property>
      <Property name="Points" id="6844.Points" number_of_elements="8">
        <Element index="0" value="1"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0.5"/>
        <Element index="3" value="0"/>
        <Element index="4" value="9245"/>
        <Element index="5" value="1"/>
        <Element index="6" value="0.5"/>
        <Element index="7" value="0"/>
      </Property>
      <Property name="ScalarRangeInitialized" id="6844.ScalarRangeInitialized" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6844.ScalarRangeInitialized.bool"/>
      </Property>
      <Property name="UseLogScale" id="6844.UseLogScale" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6844.UseLogScale.bool"/>
      </Property>
    </Proxy>
    <Proxy group="representations" type="PolarAxesRepresentation" id="6712" servers="21">
      <Property name="AllTicksVisibility" id="6712.AllTicksVisibility" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6712.AllTicksVisibility.bool"/>
      </Property>
      <Property name="ArcMajorTickSize" id="6712.ArcMajorTickSize" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="6712.ArcMajorTickSize.range"/>
      </Property>
      <Property name="ArcMajorTickThickness" id="6712.ArcMajorTickThickness" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="6712.ArcMajorTickThickness.range"/>
      </Property>
      <Property name="ArcMinorTickVisibility" id="6712.ArcMinorTickVisibility" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6712.ArcMinorTickVisibility.bool"/>
      </Property>
      <Property name="ArcTickMatchesRadialAxes" id="6712.ArcTickMatchesRadialAxes" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6712.ArcTickMatchesRadialAxes.bool"/>
      </Property>
      <Property name="ArcTickRatioSize" id="6712.ArcTickRatioSize" number_of_elements="1">
        <Element index="0" value="0.3"/>
        <Domain name="range" id="6712.ArcTickRatioSize.range"/>
      </Property>
      <Property name="ArcTickRatioThickness" id="6712.ArcTickRatioThickness" number_of_elements="1">
        <Element index="0" value="0.5"/>
        <Domain name="range" id="6712.ArcTickRatioThickness.range"/>
      </Property>
      <Property name="ArcTickVisibility" id="6712.ArcTickVisibility" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6712.ArcTickVisibility.bool"/>
      </Property>
      <Property name="ArcTicksOriginToPolarAxis" id="6712.ArcTicksOriginToPolarAxis" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6712.ArcTicksOriginToPolarAxis.bool"/>
      </Property>
      <Property name="AutoPole" id="6712.AutoPole" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6712.AutoPole.bool"/>
      </Property>
      <Property name="AxisMinorTickVisibility" id="6712.AxisMinorTickVisibility" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6712.AxisMinorTickVisibility.bool"/>
      </Property>
      <Property name="AxisTickMatchesPolarAxes" id="6712.AxisTickMatchesPolarAxes" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6712.AxisTickMatchesPolarAxes.bool"/>
      </Property>
      <Property name="AxisTickVisibility" id="6712.AxisTickVisibility" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6712.AxisTickVisibility.bool"/>
      </Property>
      <Property name="CustomAngles" id="6712.CustomAngles" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6712.CustomAngles.bool"/>
      </Property>
      <Property name="CustomBounds" id="6712.CustomBounds" number_of_elements="6">
        <Element index="0" value="0"/>
        <Element index="1" value="1"/>
        <Element index="2" value="0"/>
        <Element index="3" value="1"/>
        <Element index="4" value="0"/>
        <Element index="5" value="1"/>
      </Property>
      <Property name="CustomMaxRadius" id="6712.CustomMaxRadius" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6712.CustomMaxRadius.bool"/>
      </Property>
      <Property name="CustomMinRadius" id="6712.CustomMinRadius" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6712.CustomMinRadius.bool"/>
      </Property>
      <Property name="CustomRange" id="6712.CustomRange" number_of_elements="2">
        <Element index="0" value="0"/>
        <Element index="1" value="1"/>
      </Property>
      <Property name="DataBounds" id="6712.DataBounds" number_of_elements="6">
        <Element index="0" value="0"/>
        <Element index="1" value="1"/>
        <Element index="2" value="0"/>
        <Element index="3" value="1"/>
        <Element index="4" value="0"/>
        <Element index="5" value="1"/>
      </Property>
      <Property name="DeltaAngleMajor" id="6712.DeltaAngleMajor" number_of_elements="1">
        <Element index="0" value="10"/>
        <Domain name="range" id="6712.DeltaAngleMajor.range"/>
      </Property>
      <Property name="DeltaAngleMinor" id="6712.DeltaAngleMinor" number_of_elements="1">
        <Element index="0" value="5"/>
        <Domain name="range" id="6712.DeltaAngleMinor.range"/>
      </Property>
      <Property name="DeltaAngleRadialAxes" id="6712.DeltaAngleRadialAxes" number_of_elements="1">
        <Element index="0" value="45"/>
        <Domain name="range" id="6712.DeltaAngleRadialAxes.range"/>
      </Property>
      <Property name="DeltaRangeArcs" id="6712.DeltaRangeArcs" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="6712.DeltaRangeArcs.range"/>
      </Property>
      <Property name="DeltaRangeMajor" id="6712.DeltaRangeMajor" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="6712.DeltaRangeMajor.range"/>
      </Property>
      <Property name="DeltaRangeMinor" id="6712.DeltaRangeMinor" number_of_elements="1">
        <Element index="0" value="0.5"/>
        <Domain name="range" id="6712.DeltaRangeMinor.range"/>
      </Property>
      <Property name="DistanceLODThreshold" id="6712.DistanceLODThreshold" number_of_elements="1">
        <Element index="0" value="0.7"/>
        <Domain name="range" id="6712.DistanceLODThreshold.range"/>
      </Property>
      <Property name="DrawPolarArcsGridlines" id="6712.DrawPolarArcsGridlines" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6712.DrawPolarArcsGridlines.bool"/>
      </Property>
      <Property name="DrawRadialGridlines" id="6712.DrawRadialGridlines" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6712.DrawRadialGridlines.bool"/>
      </Property>
      <Property name="EnableCustomBounds" id="6712.EnableCustomBounds" number_of_elements="3">
        <Element index="0" value="0"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0"/>
      </Property>
      <Property name="EnableCustomRange" id="6712.EnableCustomRange" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6712.EnableCustomRange.bool"/>
      </Property>
      <Property name="EnableDistanceLOD" id="6712.EnableDistanceLOD" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6712.EnableDistanceLOD.bool"/>
      </Property>
      <Property name="EnableOverallColor" id="6712.EnableOverallColor" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6712.EnableOverallColor.bool"/>
      </Property>
      <Property name="EnableViewAngleLOD" id="6712.EnableViewAngleLOD" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6712.EnableViewAngleLOD.bool"/>
      </Property>
      <Property name="Input" id="6712.Input" number_of_elements="1">
        <Proxy value="6577" output_port="0"/>
        <Domain name="input_type" id="6712.Input.input_type"/>
      </Property>
      <Property name="LastRadialAxisColor" id="6712.LastRadialAxisColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="6712.LastRadialAxisColor.range"/>
      </Property>
      <Property name="LastRadialAxisMajorTickSize" id="6712.LastRadialAxisMajorTickSize" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="6712.LastRadialAxisMajorTickSize.range"/>
      </Property>
      <Property name="LastRadialAxisMajorTickThickness" id="6712.LastRadialAxisMajorTickThickness" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="6712.LastRadialAxisMajorTickThickness.range"/>
      </Property>
      <Property name="LastRadialAxisTickRatioSize" id="6712.LastRadialAxisTickRatioSize" number_of_elements="1">
        <Element index="0" value="0.3"/>
        <Domain name="range" id="6712.LastRadialAxisTickRatioSize.range"/>
      </Property>
      <Property name="LastRadialAxisTickRatioThickness" id="6712.LastRadialAxisTickRatioThickness" number_of_elements="1">
        <Element index="0" value="0.5"/>
        <Domain name="range" id="6712.LastRadialAxisTickRatioThickness.range"/>
      </Property>
      <Property name="MaximumAngle" id="6712.MaximumAngle" number_of_elements="1">
        <Element index="0" value="90"/>
        <Domain name="range" id="6712.MaximumAngle.range"/>
      </Property>
      <Property name="MaximumRadius" id="6712.MaximumRadius" number_of_elements="1">
        <Element index="0" value="4.3147975082902095"/>
        <Domain name="range" id="6712.MaximumRadius.range"/>
      </Property>
      <Property name="MinimumAngle" id="6712.MinimumAngle" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="6712.MinimumAngle.range"/>
      </Property>
      <Property name="MinimumRadius" id="6712.MinimumRadius" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="6712.MinimumRadius.range"/>
      </Property>
      <Property name="NumberOfArcs" id="6712.NumberOfArcs" number_of_elements="1">
        <Element index="0" value="5"/>
        <Domain name="range" id="6712.NumberOfArcs.range"/>
      </Property>
      <Property name="NumberOfRadialAxes" id="6712.NumberOfRadialAxes" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="6712.NumberOfRadialAxes.range"/>
      </Property>
      <Property name="Orientation" id="6712.Orientation" number_of_elements="3">
        <Element index="0" value="0"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0"/>
      </Property>
      <Property name="OverallColor" id="6712.OverallColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="6712.OverallColor.range"/>
      </Property>
      <Property name="PolarArcResolutionPerDegree" id="6712.PolarArcResolutionPerDegree" number_of_elements="1">
        <Element index="0" value="0.2"/>
        <Domain name="range" id="6712.PolarArcResolutionPerDegree.range"/>
      </Property>
      <Property name="PolarArcsColor" id="6712.PolarArcsColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="6712.PolarArcsColor.range"/>
      </Property>
      <Property name="PolarArcsVisibility" id="6712.PolarArcsVisibility" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6712.PolarArcsVisibility.bool"/>
      </Property>
      <Property name="PolarAxisColor" id="6712.PolarAxisColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="6712.PolarAxisColor.range"/>
      </Property>
      <Property name="PolarAxisMajorTickSize" id="6712.PolarAxisMajorTickSize" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="6712.PolarAxisMajorTickSize.range"/>
      </Property>
      <Property name="PolarAxisMajorTickThickness" id="6712.PolarAxisMajorTickThickness" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="6712.PolarAxisMajorTickThickness.range"/>
      </Property>
      <Property name="PolarAxisTickRatioSize" id="6712.PolarAxisTickRatioSize" number_of_elements="1">
        <Element index="0" value="0.3"/>
        <Domain name="range" id="6712.PolarAxisTickRatioSize.range"/>
      </Property>
      <Property name="PolarAxisTickRatioThickness" id="6712.PolarAxisTickRatioThickness" number_of_elements="1">
        <Element index="0" value="0.5"/>
        <Domain name="range" id="6712.PolarAxisTickRatioThickness.range"/>
      </Property>
      <Property name="PolarAxisTitle" id="6712.PolarAxisTitle" number_of_elements="1">
        <Element index="0" value="Radial Distance"/>
      </Property>
      <Property name="PolarAxisTitleLocation" id="6712.PolarAxisTitleLocation" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="6712.PolarAxisTitleLocation.enum">
          <Entry value="0" text="Bottom"/>
          <Entry value="1" text="Extern"/>
        </Domain>
      </Property>
      <Property name="PolarAxisTitleVisibility" id="6712.PolarAxisTitleVisibility" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6712.PolarAxisTitleVisibility.bool"/>
      </Property>
      <Property name="PolarAxisVisibility" id="6712.PolarAxisVisibility" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6712.PolarAxisVisibility.bool"/>
      </Property>
      <Property name="PolarExponentOffset" id="6712.PolarExponentOffset" number_of_elements="1">
        <Element index="0" value="5"/>
        <Domain name="range" id="6712.PolarExponentOffset.range"/>
      </Property>
      <Property name="PolarLabelExponentLocation" id="6712.PolarLabelExponentLocation" number_of_elements="1">
        <Element index="0" value="2"/>
        <Domain name="enum" id="6712.PolarLabelExponentLocation.enum">
          <Entry value="0" text="Bottom"/>
          <Entry value="1" text="Extern"/>
          <Entry value="2" text="Labels"/>
        </Domain>
      </Property>
      <Property name="PolarLabelFormat" id="6712.PolarLabelFormat" number_of_elements="1">
        <Element index="0" value="{:&#x3c;#6.3g}"/>
      </Property>
      <Property name="PolarLabelOffset" id="6712.PolarLabelOffset" number_of_elements="1">
        <Element index="0" value="10"/>
        <Domain name="range" id="6712.PolarLabelOffset.range"/>
      </Property>
      <Property name="PolarLabelVisibility" id="6712.PolarLabelVisibility" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6712.PolarLabelVisibility.bool"/>
      </Property>
      <Property name="PolarTitleOffset" id="6712.PolarTitleOffset" number_of_elements="2">
        <Element index="0" value="20"/>
        <Element index="1" value="20"/>
        <Domain name="range" id="6712.PolarTitleOffset.range"/>
      </Property>
      <Property name="PolePosition" id="6712.PolePosition" number_of_elements="3">
        <Element index="0" value="0"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0"/>
      </Property>
      <Property name="Position" id="6712.Position" number_of_elements="3">
        <Element index="0" value="0"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0"/>
      </Property>
      <Property name="RadialAxesOriginToPolarAxis" id="6712.RadialAxesOriginToPolarAxis" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6712.RadialAxesOriginToPolarAxis.bool"/>
      </Property>
      <Property name="RadialAxesVisibility" id="6712.RadialAxesVisibility" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6712.RadialAxesVisibility.bool"/>
      </Property>
      <Property name="RadialLabelFormat" id="6712.RadialLabelFormat" number_of_elements="1">
        <Element index="0" value="{:&#x3c;#3.1f}"/>
      </Property>
      <Property name="RadialLabelLocation" id="6712.RadialLabelLocation" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="6712.RadialLabelLocation.enum">
          <Entry value="0" text="Bottom"/>
          <Entry value="1" text="Extern"/>
        </Domain>
      </Property>
      <Property name="RadialLabelOffset" id="6712.RadialLabelOffset" number_of_elements="2">
        <Element index="0" value="20"/>
        <Element index="1" value="0"/>
        <Domain name="range" id="6712.RadialLabelOffset.range"/>
      </Property>
      <Property name="RadialLabelVisibility" id="6712.RadialLabelVisibility" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6712.RadialLabelVisibility.bool"/>
      </Property>
      <Property name="RadialUnitsVisibility" id="6712.RadialUnitsVisibility" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6712.RadialUnitsVisibility.bool"/>
      </Property>
      <Property name="RasterizeText" id="6712.RasterizeText" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6712.RasterizeText.bool"/>
      </Property>
      <Property name="Ratio" id="6712.Ratio" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="6712.Ratio.range"/>
      </Property>
      <Property name="Scale" id="6712.Scale" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
      </Property>
      <Property name="ScreenSize" id="6712.ScreenSize" number_of_elements="1">
        <Element index="0" value="10"/>
        <Domain name="range" id="6712.ScreenSize.range"/>
      </Property>
      <Property name="SecondaryPolarArcsColor" id="6712.SecondaryPolarArcsColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="6712.SecondaryPolarArcsColor.range"/>
      </Property>
      <Property name="SecondaryRadialAxesColor" id="6712.SecondaryRadialAxesColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="6712.SecondaryRadialAxesColor.range"/>
      </Property>
      <Property name="SmallestVisiblePolarAngle" id="6712.SmallestVisiblePolarAngle" number_of_elements="1">
        <Element index="0" value="0.5"/>
        <Domain name="range" id="6712.SmallestVisiblePolarAngle.range"/>
      </Property>
      <Property name="TickLocation" id="6712.TickLocation" number_of_elements="1">
        <Element index="0" value="2"/>
        <Domain name="enum" id="6712.TickLocation.enum">
          <Entry value="0" text="Inside"/>
          <Entry value="1" text="Outside"/>
          <Entry value="2" text="Both"/>
        </Domain>
      </Property>
      <Property name="TickRatioRadiusSize" id="6712.TickRatioRadiusSize" number_of_elements="1">
        <Element index="0" value="0.02"/>
        <Domain name="range" id="6712.TickRatioRadiusSize.range"/>
      </Property>
      <Property name="Use2DMode" id="6712.Use2DMode" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6712.Use2DMode.bool"/>
      </Property>
      <Property name="UseLogAxis" id="6712.UseLogAxis" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6712.UseLogAxis.bool"/>
      </Property>
      <Property name="ViewAngleLODThreshold" id="6712.ViewAngleLODThreshold" number_of_elements="1">
        <Element index="0" value="0.7"/>
        <Domain name="range" id="6712.ViewAngleLODThreshold.range"/>
      </Property>
      <Property name="Visibility" id="6712.Visibility" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6712.Visibility.bool"/>
      </Property>
      <Property name="LastRadialAxisTextBold" id="6712.LastRadialAxisTextBold" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6712.LastRadialAxisTextBold.bool"/>
      </Property>
      <Property name="LastRadialAxisTextColor" id="6712.LastRadialAxisTextColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="6712.LastRadialAxisTextColor.range"/>
      </Property>
      <Property name="LastRadialAxisTextFontFamily" id="6712.LastRadialAxisTextFontFamily" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="6712.LastRadialAxisTextFontFamily.enum">
          <Entry value="0" text="Arial"/>
          <Entry value="1" text="Courier"/>
          <Entry value="2" text="Times"/>
          <Entry value="4" text="File"/>
        </Domain>
      </Property>
      <Property name="LastRadialAxisTextFontFile" id="6712.LastRadialAxisTextFontFile" number_of_elements="1">
        <Element index="0" value=""/>
      </Property>
      <Property name="LastRadialAxisTextFontSize" id="6712.LastRadialAxisTextFontSize" number_of_elements="1">
        <Element index="0" value="12"/>
        <Domain name="range" id="6712.LastRadialAxisTextFontSize.range"/>
      </Property>
      <Property name="LastRadialAxisTextItalic" id="6712.LastRadialAxisTextItalic" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6712.LastRadialAxisTextItalic.bool"/>
      </Property>
      <Property name="LastRadialAxisTextOpacity" id="6712.LastRadialAxisTextOpacity" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="6712.LastRadialAxisTextOpacity.range"/>
      </Property>
      <Property name="LastRadialAxisTextShadow" id="6712.LastRadialAxisTextShadow" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6712.LastRadialAxisTextShadow.bool"/>
      </Property>
      <Property name="PolarAxisLabelBold" id="6712.PolarAxisLabelBold" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6712.PolarAxisLabelBold.bool"/>
      </Property>
      <Property name="PolarAxisLabelColor" id="6712.PolarAxisLabelColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="6712.PolarAxisLabelColor.range"/>
      </Property>
      <Property name="PolarAxisLabelFontFamily" id="6712.PolarAxisLabelFontFamily" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="6712.PolarAxisLabelFontFamily.enum">
          <Entry value="0" text="Arial"/>
          <Entry value="1" text="Courier"/>
          <Entry value="2" text="Times"/>
          <Entry value="4" text="File"/>
        </Domain>
      </Property>
      <Property name="PolarAxisLabelFontFile" id="6712.PolarAxisLabelFontFile" number_of_elements="1">
        <Element index="0" value=""/>
      </Property>
      <Property name="PolarAxisLabelFontSize" id="6712.PolarAxisLabelFontSize" number_of_elements="1">
        <Element index="0" value="12"/>
        <Domain name="range" id="6712.PolarAxisLabelFontSize.range"/>
      </Property>
      <Property name="PolarAxisLabelItalic" id="6712.PolarAxisLabelItalic" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6712.PolarAxisLabelItalic.bool"/>
      </Property>
      <Property name="PolarAxisLabelOpacity" id="6712.PolarAxisLabelOpacity" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="6712.PolarAxisLabelOpacity.range"/>
      </Property>
      <Property name="PolarAxisLabelShadow" id="6712.PolarAxisLabelShadow" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6712.PolarAxisLabelShadow.bool"/>
      </Property>
      <Property name="PolarAxisTitleBold" id="6712.PolarAxisTitleBold" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6712.PolarAxisTitleBold.bool"/>
      </Property>
      <Property name="PolarAxisTitleColor" id="6712.PolarAxisTitleColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="6712.PolarAxisTitleColor.range"/>
      </Property>
      <Property name="PolarAxisTitleFontFamily" id="6712.PolarAxisTitleFontFamily" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="6712.PolarAxisTitleFontFamily.enum">
          <Entry value="0" text="Arial"/>
          <Entry value="1" text="Courier"/>
          <Entry value="2" text="Times"/>
          <Entry value="4" text="File"/>
        </Domain>
      </Property>
      <Property name="PolarAxisTitleFontFile" id="6712.PolarAxisTitleFontFile" number_of_elements="1">
        <Element index="0" value=""/>
      </Property>
      <Property name="PolarAxisTitleFontSize" id="6712.PolarAxisTitleFontSize" number_of_elements="1">
        <Element index="0" value="12"/>
        <Domain name="range" id="6712.PolarAxisTitleFontSize.range"/>
      </Property>
      <Property name="PolarAxisTitleItalic" id="6712.PolarAxisTitleItalic" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6712.PolarAxisTitleItalic.bool"/>
      </Property>
      <Property name="PolarAxisTitleOpacity" id="6712.PolarAxisTitleOpacity" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="6712.PolarAxisTitleOpacity.range"/>
      </Property>
      <Property name="PolarAxisTitleShadow" id="6712.PolarAxisTitleShadow" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6712.PolarAxisTitleShadow.bool"/>
      </Property>
      <Property name="SecondaryRadialAxesTextBold" id="6712.SecondaryRadialAxesTextBold" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6712.SecondaryRadialAxesTextBold.bool"/>
      </Property>
      <Property name="SecondaryRadialAxesTextColor" id="6712.SecondaryRadialAxesTextColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="6712.SecondaryRadialAxesTextColor.range"/>
      </Property>
      <Property name="SecondaryRadialAxesTextFontFamily" id="6712.SecondaryRadialAxesTextFontFamily" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="6712.SecondaryRadialAxesTextFontFamily.enum">
          <Entry value="0" text="Arial"/>
          <Entry value="1" text="Courier"/>
          <Entry value="2" text="Times"/>
          <Entry value="4" text="File"/>
        </Domain>
      </Property>
      <Property name="SecondaryRadialAxesTextFontFile" id="6712.SecondaryRadialAxesTextFontFile" number_of_elements="1">
        <Element index="0" value=""/>
      </Property>
      <Property name="SecondaryRadialAxesTextFontSize" id="6712.SecondaryRadialAxesTextFontSize" number_of_elements="1">
        <Element index="0" value="12"/>
        <Domain name="range" id="6712.SecondaryRadialAxesTextFontSize.range"/>
      </Property>
      <Property name="SecondaryRadialAxesTextItalic" id="6712.SecondaryRadialAxesTextItalic" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6712.SecondaryRadialAxesTextItalic.bool"/>
      </Property>
      <Property name="SecondaryRadialAxesTextOpacity" id="6712.SecondaryRadialAxesTextOpacity" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="6712.SecondaryRadialAxesTextOpacity.range"/>
      </Property>
      <Property name="SecondaryRadialAxesTextShadow" id="6712.SecondaryRadialAxesTextShadow" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6712.SecondaryRadialAxesTextShadow.bool"/>
      </Property>
    </Proxy>
    <Proxy group="piecewise_functions" type="PiecewiseFunction" id="6845" servers="21">
      <Property name="AllowDuplicateScalars" id="6845.AllowDuplicateScalars" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6845.AllowDuplicateScalars.bool"/>
      </Property>
      <Property name="Points" id="6845.Points" number_of_elements="8">
        <Element index="0" value="1"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0.5"/>
        <Element index="3" value="0"/>
        <Element index="4" value="9245"/>
        <Element index="5" value="1"/>
        <Element index="6" value="0.5"/>
        <Element index="7" value="0"/>
      </Property>
      <Property name="ScalarRangeInitialized" id="6845.ScalarRangeInitialized" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6845.ScalarRangeInitialized.bool"/>
      </Property>
      <Property name="UseLogScale" id="6845.UseLogScale" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6845.UseLogScale.bool"/>
      </Property>
    </Proxy>
    <Proxy group="extended_sources" type="Transform2" id="6891" servers="21">
      <Property name="Position" id="6891.Position" number_of_elements="3">
        <Element index="0" value="0"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0"/>
        <Domain name="range" id="6891.Position.range"/>
      </Property>
      <Property name="PositionInfo" id="6891.PositionInfo" number_of_elements="3">
        <Element index="0" value="0"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0"/>
      </Property>
      <Property name="Rotation" id="6891.Rotation" number_of_elements="3">
        <Element index="0" value="0"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0"/>
        <Domain name="range" id="6891.Rotation.range"/>
      </Property>
      <Property name="RotationInfo" id="6891.RotationInfo" number_of_elements="3">
        <Element index="0" value="0"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0"/>
      </Property>
      <Property name="Scale" id="6891.Scale" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="6891.Scale.range"/>
      </Property>
      <Property name="ScaleInfo" id="6891.ScaleInfo" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
      </Property>
    </Proxy>
    <Proxy group="misc" type="RepresentationAnimationHelper" id="6986" servers="16">
      <Property name="Source" id="6986.Source" number_of_elements="1">
        <Proxy value="6975"/>
      </Property>
    </Proxy>
    <Proxy group="representations" type="GridAxesRepresentation" id="6995" servers="21">
      <Property name="GridAxesVisibility" id="6995.GridAxesVisibility" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6995.GridAxesVisibility.bool"/>
      </Property>
      <Property name="Input" id="6995.Input">
        <Domain name="input_array_any" id="6995.Input.input_array_any"/>
      </Property>
      <Property name="Position" id="6995.Position" number_of_elements="3">
        <Element index="0" value="0"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0"/>
        <Domain name="range" id="6995.Position.range"/>
      </Property>
      <Property name="Scale" id="6995.Scale" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="6995.Scale.range"/>
      </Property>
      <Property name="AxesToLabel" id="6995.AxesToLabel" number_of_elements="1">
        <Element index="0" value="63"/>
        <Domain name="range" id="6995.AxesToLabel.range"/>
      </Property>
      <Property name="CullBackface" id="6995.CullBackface" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6995.CullBackface.bool"/>
      </Property>
      <Property name="CullFrontface" id="6995.CullFrontface" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6995.CullFrontface.bool"/>
      </Property>
      <Property name="CustomBounds" id="6995.CustomBounds" number_of_elements="6">
        <Element index="0" value="0"/>
        <Element index="1" value="1"/>
        <Element index="2" value="0"/>
        <Element index="3" value="1"/>
        <Element index="4" value="0"/>
        <Element index="5" value="1"/>
        <Domain name="range" id="6995.CustomBounds.range"/>
      </Property>
      <Property name="FacesToRender" id="6995.FacesToRender" number_of_elements="1">
        <Element index="0" value="63"/>
        <Domain name="range" id="6995.FacesToRender.range"/>
      </Property>
      <Property name="GridColor" id="6995.GridColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="6995.GridColor.range"/>
      </Property>
      <Property name="IgnoreDisplayTransformScale" id="6995.IgnoreDisplayTransformScale" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6995.IgnoreDisplayTransformScale.bool"/>
      </Property>
      <Property name="LabelUniqueEdgesOnly" id="6995.LabelUniqueEdgesOnly" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6995.LabelUniqueEdgesOnly.bool"/>
      </Property>
      <Property name="ShowEdges" id="6995.ShowEdges" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6995.ShowEdges.bool"/>
      </Property>
      <Property name="ShowGrid" id="6995.ShowGrid" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6995.ShowGrid.bool"/>
      </Property>
      <Property name="ShowTicks" id="6995.ShowTicks" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6995.ShowTicks.bool"/>
      </Property>
      <Property name="UseCustomBounds" id="6995.UseCustomBounds" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6995.UseCustomBounds.bool"/>
      </Property>
      <Property name="XAxisLabels" id="6995.XAxisLabels">
        <Domain name="scalar_range" id="6995.XAxisLabels.scalar_range"/>
      </Property>
      <Property name="XAxisNotation" id="6995.XAxisNotation" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="6995.XAxisNotation.enum">
          <Entry value="0" text="Mixed"/>
          <Entry value="1" text="Scientific"/>
          <Entry value="2" text="Fixed"/>
        </Domain>
      </Property>
      <Property name="XAxisPrecision" id="6995.XAxisPrecision" number_of_elements="1">
        <Element index="0" value="2"/>
        <Domain name="range" id="6995.XAxisPrecision.range"/>
      </Property>
      <Property name="XAxisUseCustomLabels" id="6995.XAxisUseCustomLabels" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6995.XAxisUseCustomLabels.bool"/>
      </Property>
      <Property name="XLabelBold" id="6995.XLabelBold" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6995.XLabelBold.bool"/>
      </Property>
      <Property name="XLabelColor" id="6995.XLabelColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="6995.XLabelColor.range"/>
      </Property>
      <Property name="XLabelFontFamily" id="6995.XLabelFontFamily" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="6995.XLabelFontFamily.enum">
          <Entry value="0" text="Arial"/>
          <Entry value="1" text="Courier"/>
          <Entry value="2" text="Times"/>
          <Entry value="4" text="File"/>
        </Domain>
      </Property>
      <Property name="XLabelFontFile" id="6995.XLabelFontFile" number_of_elements="1">
        <Element index="0" value=""/>
      </Property>
      <Property name="XLabelFontSize" id="6995.XLabelFontSize" number_of_elements="1">
        <Element index="0" value="12"/>
        <Domain name="range" id="6995.XLabelFontSize.range"/>
      </Property>
      <Property name="XLabelItalic" id="6995.XLabelItalic" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6995.XLabelItalic.bool"/>
      </Property>
      <Property name="XLabelOpacity" id="6995.XLabelOpacity" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="6995.XLabelOpacity.range"/>
      </Property>
      <Property name="XLabelShadow" id="6995.XLabelShadow" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6995.XLabelShadow.bool"/>
      </Property>
      <Property name="XTitle" id="6995.XTitle" number_of_elements="1">
        <Element index="0" value="X Axis"/>
      </Property>
      <Property name="XTitleBold" id="6995.XTitleBold" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6995.XTitleBold.bool"/>
      </Property>
      <Property name="XTitleColor" id="6995.XTitleColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="6995.XTitleColor.range"/>
      </Property>
      <Property name="XTitleFontFamily" id="6995.XTitleFontFamily" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="6995.XTitleFontFamily.enum">
          <Entry value="0" text="Arial"/>
          <Entry value="1" text="Courier"/>
          <Entry value="2" text="Times"/>
          <Entry value="4" text="File"/>
        </Domain>
      </Property>
      <Property name="XTitleFontFile" id="6995.XTitleFontFile" number_of_elements="1">
        <Element index="0" value=""/>
      </Property>
      <Property name="XTitleFontSize" id="6995.XTitleFontSize" number_of_elements="1">
        <Element index="0" value="12"/>
        <Domain name="range" id="6995.XTitleFontSize.range"/>
      </Property>
      <Property name="XTitleItalic" id="6995.XTitleItalic" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6995.XTitleItalic.bool"/>
      </Property>
      <Property name="XTitleOpacity" id="6995.XTitleOpacity" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="6995.XTitleOpacity.range"/>
      </Property>
      <Property name="XTitleShadow" id="6995.XTitleShadow" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6995.XTitleShadow.bool"/>
      </Property>
      <Property name="YAxisLabels" id="6995.YAxisLabels">
        <Domain name="scalar_range" id="6995.YAxisLabels.scalar_range"/>
      </Property>
      <Property name="YAxisNotation" id="6995.YAxisNotation" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="6995.YAxisNotation.enum">
          <Entry value="0" text="Mixed"/>
          <Entry value="1" text="Scientific"/>
          <Entry value="2" text="Fixed"/>
        </Domain>
      </Property>
      <Property name="YAxisPrecision" id="6995.YAxisPrecision" number_of_elements="1">
        <Element index="0" value="2"/>
        <Domain name="range" id="6995.YAxisPrecision.range"/>
      </Property>
      <Property name="YAxisUseCustomLabels" id="6995.YAxisUseCustomLabels" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6995.YAxisUseCustomLabels.bool"/>
      </Property>
      <Property name="YLabelBold" id="6995.YLabelBold" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6995.YLabelBold.bool"/>
      </Property>
      <Property name="YLabelColor" id="6995.YLabelColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="6995.YLabelColor.range"/>
      </Property>
      <Property name="YLabelFontFamily" id="6995.YLabelFontFamily" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="6995.YLabelFontFamily.enum">
          <Entry value="0" text="Arial"/>
          <Entry value="1" text="Courier"/>
          <Entry value="2" text="Times"/>
          <Entry value="4" text="File"/>
        </Domain>
      </Property>
      <Property name="YLabelFontFile" id="6995.YLabelFontFile" number_of_elements="1">
        <Element index="0" value=""/>
      </Property>
      <Property name="YLabelFontSize" id="6995.YLabelFontSize" number_of_elements="1">
        <Element index="0" value="12"/>
        <Domain name="range" id="6995.YLabelFontSize.range"/>
      </Property>
      <Property name="YLabelItalic" id="6995.YLabelItalic" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6995.YLabelItalic.bool"/>
      </Property>
      <Property name="YLabelOpacity" id="6995.YLabelOpacity" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="6995.YLabelOpacity.range"/>
      </Property>
      <Property name="YLabelShadow" id="6995.YLabelShadow" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6995.YLabelShadow.bool"/>
      </Property>
      <Property name="YTitle" id="6995.YTitle" number_of_elements="1">
        <Element index="0" value="Y Axis"/>
      </Property>
      <Property name="YTitleBold" id="6995.YTitleBold" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6995.YTitleBold.bool"/>
      </Property>
      <Property name="YTitleColor" id="6995.YTitleColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="6995.YTitleColor.range"/>
      </Property>
      <Property name="YTitleFontFamily" id="6995.YTitleFontFamily" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="6995.YTitleFontFamily.enum">
          <Entry value="0" text="Arial"/>
          <Entry value="1" text="Courier"/>
          <Entry value="2" text="Times"/>
          <Entry value="4" text="File"/>
        </Domain>
      </Property>
      <Property name="YTitleFontFile" id="6995.YTitleFontFile" number_of_elements="1">
        <Element index="0" value=""/>
      </Property>
      <Property name="YTitleFontSize" id="6995.YTitleFontSize" number_of_elements="1">
        <Element index="0" value="12"/>
        <Domain name="range" id="6995.YTitleFontSize.range"/>
      </Property>
      <Property name="YTitleItalic" id="6995.YTitleItalic" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6995.YTitleItalic.bool"/>
      </Property>
      <Property name="YTitleOpacity" id="6995.YTitleOpacity" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="6995.YTitleOpacity.range"/>
      </Property>
      <Property name="YTitleShadow" id="6995.YTitleShadow" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6995.YTitleShadow.bool"/>
      </Property>
      <Property name="ZAxisLabels" id="6995.ZAxisLabels">
        <Domain name="scalar_range" id="6995.ZAxisLabels.scalar_range"/>
      </Property>
      <Property name="ZAxisNotation" id="6995.ZAxisNotation" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="6995.ZAxisNotation.enum">
          <Entry value="0" text="Mixed"/>
          <Entry value="1" text="Scientific"/>
          <Entry value="2" text="Fixed"/>
        </Domain>
      </Property>
      <Property name="ZAxisPrecision" id="6995.ZAxisPrecision" number_of_elements="1">
        <Element index="0" value="2"/>
        <Domain name="range" id="6995.ZAxisPrecision.range"/>
      </Property>
      <Property name="ZAxisUseCustomLabels" id="6995.ZAxisUseCustomLabels" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6995.ZAxisUseCustomLabels.bool"/>
      </Property>
      <Property name="ZLabelBold" id="6995.ZLabelBold" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6995.ZLabelBold.bool"/>
      </Property>
      <Property name="ZLabelColor" id="6995.ZLabelColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="6995.ZLabelColor.range"/>
      </Property>
      <Property name="ZLabelFontFamily" id="6995.ZLabelFontFamily" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="6995.ZLabelFontFamily.enum">
          <Entry value="0" text="Arial"/>
          <Entry value="1" text="Courier"/>
          <Entry value="2" text="Times"/>
          <Entry value="4" text="File"/>
        </Domain>
      </Property>
      <Property name="ZLabelFontFile" id="6995.ZLabelFontFile" number_of_elements="1">
        <Element index="0" value=""/>
      </Property>
      <Property name="ZLabelFontSize" id="6995.ZLabelFontSize" number_of_elements="1">
        <Element index="0" value="12"/>
        <Domain name="range" id="6995.ZLabelFontSize.range"/>
      </Property>
      <Property name="ZLabelItalic" id="6995.ZLabelItalic" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6995.ZLabelItalic.bool"/>
      </Property>
      <Property name="ZLabelOpacity" id="6995.ZLabelOpacity" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="6995.ZLabelOpacity.range"/>
      </Property>
      <Property name="ZLabelShadow" id="6995.ZLabelShadow" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6995.ZLabelShadow.bool"/>
      </Property>
      <Property name="ZTitle" id="6995.ZTitle" number_of_elements="1">
        <Element index="0" value="Z Axis"/>
      </Property>
      <Property name="ZTitleBold" id="6995.ZTitleBold" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6995.ZTitleBold.bool"/>
      </Property>
      <Property name="ZTitleColor" id="6995.ZTitleColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="6995.ZTitleColor.range"/>
      </Property>
      <Property name="ZTitleFontFamily" id="6995.ZTitleFontFamily" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="6995.ZTitleFontFamily.enum">
          <Entry value="0" text="Arial"/>
          <Entry value="1" text="Courier"/>
          <Entry value="2" text="Times"/>
          <Entry value="4" text="File"/>
        </Domain>
      </Property>
      <Property name="ZTitleFontFile" id="6995.ZTitleFontFile" number_of_elements="1">
        <Element index="0" value=""/>
      </Property>
      <Property name="ZTitleFontSize" id="6995.ZTitleFontSize" number_of_elements="1">
        <Element index="0" value="12"/>
        <Domain name="range" id="6995.ZTitleFontSize.range"/>
      </Property>
      <Property name="ZTitleItalic" id="6995.ZTitleItalic" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6995.ZTitleItalic.bool"/>
      </Property>
      <Property name="ZTitleOpacity" id="6995.ZTitleOpacity" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="6995.ZTitleOpacity.range"/>
      </Property>
      <Property name="ZTitleShadow" id="6995.ZTitleShadow" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6995.ZTitleShadow.bool"/>
      </Property>
    </Proxy>
    <Proxy group="sources" type="ArrowSource" id="7032" servers="21">
      <Property name="Invert" id="7032.Invert" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7032.Invert.bool"/>
      </Property>
      <Property name="ShaftRadius" id="7032.ShaftRadius" number_of_elements="1">
        <Element index="0" value="0.03"/>
        <Domain name="range" id="7032.ShaftRadius.range"/>
      </Property>
      <Property name="ShaftResolution" id="7032.ShaftResolution" number_of_elements="1">
        <Element index="0" value="6"/>
        <Domain name="range" id="7032.ShaftResolution.range"/>
      </Property>
      <Property name="TipLength" id="7032.TipLength" number_of_elements="1">
        <Element index="0" value="0.35"/>
        <Domain name="range" id="7032.TipLength.range"/>
      </Property>
      <Property name="TipRadius" id="7032.TipRadius" number_of_elements="1">
        <Element index="0" value="0.1"/>
        <Domain name="range" id="7032.TipRadius.range"/>
      </Property>
      <Property name="TipResolution" id="7032.TipResolution" number_of_elements="1">
        <Element index="0" value="6"/>
        <Domain name="range" id="7032.TipResolution.range"/>
      </Property>
    </Proxy>
    <Proxy group="sources" type="ConeSource" id="7043" servers="21">
      <Property name="Capping" id="7043.Capping" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="7043.Capping.bool"/>
      </Property>
      <Property name="Center" id="7043.Center" number_of_elements="3">
        <Element index="0" value="0"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0"/>
        <Domain name="range" id="7043.Center.range"/>
      </Property>
      <Property name="Direction" id="7043.Direction" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0"/>
        <Domain name="range" id="7043.Direction.range"/>
      </Property>
      <Property name="Height" id="7043.Height" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="7043.Height.range"/>
      </Property>
      <Property name="Radius" id="7043.Radius" number_of_elements="1">
        <Element index="0" value="0.5"/>
        <Domain name="range" id="7043.Radius.range"/>
      </Property>
      <Property name="Resolution" id="7043.Resolution" number_of_elements="1">
        <Element index="0" value="6"/>
        <Domain name="range" id="7043.Resolution.range"/>
      </Property>
    </Proxy>
    <Proxy group="sources" type="CubeSource" id="7054" servers="21">
      <Property name="Center" id="7054.Center" number_of_elements="3">
        <Element index="0" value="0"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0"/>
        <Domain name="range" id="7054.Center.range"/>
      </Property>
      <Property name="XLength" id="7054.XLength" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="7054.XLength.range"/>
      </Property>
      <Property name="YLength" id="7054.YLength" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="7054.YLength.range"/>
      </Property>
      <Property name="ZLength" id="7054.ZLength" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="7054.ZLength.range"/>
      </Property>
    </Proxy>
    <Proxy group="sources" type="CylinderSource" id="7065" servers="21">
      <Property name="Capping" id="7065.Capping" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="7065.Capping.bool"/>
      </Property>
      <Property name="Center" id="7065.Center" number_of_elements="3">
        <Element index="0" value="0"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0"/>
        <Domain name="range" id="7065.Center.range"/>
      </Property>
      <Property name="Height" id="7065.Height" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="7065.Height.range"/>
      </Property>
      <Property name="Radius" id="7065.Radius" number_of_elements="1">
        <Element index="0" value="0.5"/>
        <Domain name="range" id="7065.Radius.range"/>
      </Property>
      <Property name="Resolution" id="7065.Resolution" number_of_elements="1">
        <Element index="0" value="6"/>
        <Domain name="range" id="7065.Resolution.range"/>
      </Property>
    </Proxy>
    <Proxy group="sources" type="LineSource" id="7076" servers="21">
      <Property name="Point1" id="7076.Point1" number_of_elements="3">
        <Element index="0" value="-0.5"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0"/>
        <Domain name="range" id="7076.Point1.range"/>
      </Property>
      <Property name="Point2" id="7076.Point2" number_of_elements="3">
        <Element index="0" value="0.5"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0"/>
        <Domain name="range" id="7076.Point2.range"/>
      </Property>
      <Property name="RefinementRatios" id="7076.RefinementRatios" number_of_elements="2">
        <Element index="0" value="0"/>
        <Element index="1" value="1"/>
        <Domain name="range" id="7076.RefinementRatios.range"/>
      </Property>
      <Property name="Resolution" id="7076.Resolution" number_of_elements="1">
        <Element index="0" value="6"/>
        <Domain name="range" id="7076.Resolution.range"/>
      </Property>
      <Property name="UseRegularRefinement" id="7076.UseRegularRefinement" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="7076.UseRegularRefinement.bool"/>
      </Property>
    </Proxy>
    <Proxy group="sources" type="SphereSource" id="7087" servers="21">
      <Property name="Center" id="7087.Center" number_of_elements="3">
        <Element index="0" value="0"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0"/>
        <Domain name="range" id="7087.Center.range"/>
      </Property>
      <Property name="EndPhi" id="7087.EndPhi" number_of_elements="1">
        <Element index="0" value="180"/>
        <Domain name="range" id="7087.EndPhi.range"/>
      </Property>
      <Property name="EndTheta" id="7087.EndTheta" number_of_elements="1">
        <Element index="0" value="360"/>
        <Domain name="range" id="7087.EndTheta.range"/>
      </Property>
      <Property name="PhiResolution" id="7087.PhiResolution" number_of_elements="1">
        <Element index="0" value="8"/>
        <Domain name="range" id="7087.PhiResolution.range"/>
      </Property>
      <Property name="Radius" id="7087.Radius" number_of_elements="1">
        <Element index="0" value="0.5"/>
        <Domain name="range" id="7087.Radius.range"/>
      </Property>
      <Property name="StartPhi" id="7087.StartPhi" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="7087.StartPhi.range"/>
      </Property>
      <Property name="StartTheta" id="7087.StartTheta" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="7087.StartTheta.range"/>
      </Property>
      <Property name="ThetaResolution" id="7087.ThetaResolution" number_of_elements="1">
        <Element index="0" value="8"/>
        <Domain name="range" id="7087.ThetaResolution.range"/>
      </Property>
    </Proxy>
    <Proxy group="sources" type="GlyphSource2D" id="7098" servers="21">
      <Property name="Center" id="7098.Center" number_of_elements="3">
        <Element index="0" value="0"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0"/>
        <Domain name="range" id="7098.Center.range"/>
      </Property>
      <Property name="DoublePointed" id="7098.DoublePointed" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7098.DoublePointed.bool"/>
      </Property>
      <Property name="Filled" id="7098.Filled" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7098.Filled.bool"/>
      </Property>
      <Property name="GlyphType" id="7098.GlyphType" number_of_elements="1">
        <Element index="0" value="9"/>
        <Domain name="enum" id="7098.GlyphType.enum">
          <Entry value="1" text="Vertex"/>
          <Entry value="2" text="Dash"/>
          <Entry value="3" text="Cross"/>
          <Entry value="4" text="ThickCross"/>
          <Entry value="5" text="Triangle"/>
          <Entry value="6" text="Square"/>
          <Entry value="7" text="Circle"/>
          <Entry value="8" text="Diamond"/>
          <Entry value="9" text="Arrow"/>
          <Entry value="10" text="ThickArrow"/>
          <Entry value="11" text="HookedArrow"/>
          <Entry value="12" text="EdgeArrow"/>
        </Domain>
      </Property>
      <Property name="PointInwards" id="7098.PointInwards" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7098.PointInwards.bool"/>
      </Property>
      <Property name="TipLength" id="7098.TipLength" number_of_elements="1">
        <Element index="0" value="0.3"/>
        <Domain name="range" id="7098.TipLength.range"/>
      </Property>
    </Proxy>
    <Proxy group="internal_filters" type="PipelineConnection" id="7109" servers="21">
      <Property name="AllowNullInput" id="7109.AllowNullInput" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="7109.AllowNullInput.bool"/>
      </Property>
      <Property name="Input" id="7109.Input">
        <Domain name="groups" id="7109.Input.groups"/>
        <Domain name="input_type" id="7109.Input.input_type"/>
      </Property>
    </Proxy>
    <Proxy group="piecewise_functions" type="PiecewiseFunction" id="7188" servers="21">
      <Property name="AllowDuplicateScalars" id="7188.AllowDuplicateScalars" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="7188.AllowDuplicateScalars.bool"/>
      </Property>
      <Property name="Points" id="7188.Points" number_of_elements="8">
        <Element index="0" value="0"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0.5"/>
        <Element index="3" value="0"/>
        <Element index="4" value="1"/>
        <Element index="5" value="1"/>
        <Element index="6" value="0.5"/>
        <Element index="7" value="0"/>
      </Property>
      <Property name="ScalarRangeInitialized" id="7188.ScalarRangeInitialized" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7188.ScalarRangeInitialized.bool"/>
      </Property>
      <Property name="UseLogScale" id="7188.UseLogScale" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7188.UseLogScale.bool"/>
      </Property>
    </Proxy>
    <Proxy group="piecewise_functions" type="PiecewiseFunction" id="7142" servers="21">
      <Property name="AllowDuplicateScalars" id="7142.AllowDuplicateScalars" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="7142.AllowDuplicateScalars.bool"/>
      </Property>
      <Property name="Points" id="7142.Points" number_of_elements="8">
        <Element index="0" value="1"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0.5"/>
        <Element index="3" value="0"/>
        <Element index="4" value="9245"/>
        <Element index="5" value="1"/>
        <Element index="6" value="0.5"/>
        <Element index="7" value="0"/>
      </Property>
      <Property name="ScalarRangeInitialized" id="7142.ScalarRangeInitialized" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="7142.ScalarRangeInitialized.bool"/>
      </Property>
      <Property name="UseLogScale" id="7142.UseLogScale" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7142.UseLogScale.bool"/>
      </Property>
    </Proxy>
    <Proxy group="representations" type="PolarAxesRepresentation" id="7010" servers="21">
      <Property name="AllTicksVisibility" id="7010.AllTicksVisibility" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="7010.AllTicksVisibility.bool"/>
      </Property>
      <Property name="ArcMajorTickSize" id="7010.ArcMajorTickSize" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="7010.ArcMajorTickSize.range"/>
      </Property>
      <Property name="ArcMajorTickThickness" id="7010.ArcMajorTickThickness" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="7010.ArcMajorTickThickness.range"/>
      </Property>
      <Property name="ArcMinorTickVisibility" id="7010.ArcMinorTickVisibility" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7010.ArcMinorTickVisibility.bool"/>
      </Property>
      <Property name="ArcTickMatchesRadialAxes" id="7010.ArcTickMatchesRadialAxes" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="7010.ArcTickMatchesRadialAxes.bool"/>
      </Property>
      <Property name="ArcTickRatioSize" id="7010.ArcTickRatioSize" number_of_elements="1">
        <Element index="0" value="0.3"/>
        <Domain name="range" id="7010.ArcTickRatioSize.range"/>
      </Property>
      <Property name="ArcTickRatioThickness" id="7010.ArcTickRatioThickness" number_of_elements="1">
        <Element index="0" value="0.5"/>
        <Domain name="range" id="7010.ArcTickRatioThickness.range"/>
      </Property>
      <Property name="ArcTickVisibility" id="7010.ArcTickVisibility" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="7010.ArcTickVisibility.bool"/>
      </Property>
      <Property name="ArcTicksOriginToPolarAxis" id="7010.ArcTicksOriginToPolarAxis" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="7010.ArcTicksOriginToPolarAxis.bool"/>
      </Property>
      <Property name="AutoPole" id="7010.AutoPole" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="7010.AutoPole.bool"/>
      </Property>
      <Property name="AxisMinorTickVisibility" id="7010.AxisMinorTickVisibility" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7010.AxisMinorTickVisibility.bool"/>
      </Property>
      <Property name="AxisTickMatchesPolarAxes" id="7010.AxisTickMatchesPolarAxes" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="7010.AxisTickMatchesPolarAxes.bool"/>
      </Property>
      <Property name="AxisTickVisibility" id="7010.AxisTickVisibility" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="7010.AxisTickVisibility.bool"/>
      </Property>
      <Property name="CustomAngles" id="7010.CustomAngles" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="7010.CustomAngles.bool"/>
      </Property>
      <Property name="CustomBounds" id="7010.CustomBounds" number_of_elements="6">
        <Element index="0" value="0"/>
        <Element index="1" value="1"/>
        <Element index="2" value="0"/>
        <Element index="3" value="1"/>
        <Element index="4" value="0"/>
        <Element index="5" value="1"/>
      </Property>
      <Property name="CustomMaxRadius" id="7010.CustomMaxRadius" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7010.CustomMaxRadius.bool"/>
      </Property>
      <Property name="CustomMinRadius" id="7010.CustomMinRadius" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="7010.CustomMinRadius.bool"/>
      </Property>
      <Property name="CustomRange" id="7010.CustomRange" number_of_elements="2">
        <Element index="0" value="0"/>
        <Element index="1" value="1"/>
      </Property>
      <Property name="DataBounds" id="7010.DataBounds" number_of_elements="6">
        <Element index="0" value="0"/>
        <Element index="1" value="1"/>
        <Element index="2" value="0"/>
        <Element index="3" value="1"/>
        <Element index="4" value="0"/>
        <Element index="5" value="1"/>
      </Property>
      <Property name="DeltaAngleMajor" id="7010.DeltaAngleMajor" number_of_elements="1">
        <Element index="0" value="10"/>
        <Domain name="range" id="7010.DeltaAngleMajor.range"/>
      </Property>
      <Property name="DeltaAngleMinor" id="7010.DeltaAngleMinor" number_of_elements="1">
        <Element index="0" value="5"/>
        <Domain name="range" id="7010.DeltaAngleMinor.range"/>
      </Property>
      <Property name="DeltaAngleRadialAxes" id="7010.DeltaAngleRadialAxes" number_of_elements="1">
        <Element index="0" value="45"/>
        <Domain name="range" id="7010.DeltaAngleRadialAxes.range"/>
      </Property>
      <Property name="DeltaRangeArcs" id="7010.DeltaRangeArcs" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="7010.DeltaRangeArcs.range"/>
      </Property>
      <Property name="DeltaRangeMajor" id="7010.DeltaRangeMajor" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="7010.DeltaRangeMajor.range"/>
      </Property>
      <Property name="DeltaRangeMinor" id="7010.DeltaRangeMinor" number_of_elements="1">
        <Element index="0" value="0.5"/>
        <Domain name="range" id="7010.DeltaRangeMinor.range"/>
      </Property>
      <Property name="DistanceLODThreshold" id="7010.DistanceLODThreshold" number_of_elements="1">
        <Element index="0" value="0.7"/>
        <Domain name="range" id="7010.DistanceLODThreshold.range"/>
      </Property>
      <Property name="DrawPolarArcsGridlines" id="7010.DrawPolarArcsGridlines" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="7010.DrawPolarArcsGridlines.bool"/>
      </Property>
      <Property name="DrawRadialGridlines" id="7010.DrawRadialGridlines" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="7010.DrawRadialGridlines.bool"/>
      </Property>
      <Property name="EnableCustomBounds" id="7010.EnableCustomBounds" number_of_elements="3">
        <Element index="0" value="0"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0"/>
      </Property>
      <Property name="EnableCustomRange" id="7010.EnableCustomRange" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7010.EnableCustomRange.bool"/>
      </Property>
      <Property name="EnableDistanceLOD" id="7010.EnableDistanceLOD" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="7010.EnableDistanceLOD.bool"/>
      </Property>
      <Property name="EnableOverallColor" id="7010.EnableOverallColor" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="7010.EnableOverallColor.bool"/>
      </Property>
      <Property name="EnableViewAngleLOD" id="7010.EnableViewAngleLOD" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="7010.EnableViewAngleLOD.bool"/>
      </Property>
      <Property name="Input" id="7010.Input" number_of_elements="1">
        <Proxy value="6975" output_port="0"/>
        <Domain name="input_type" id="7010.Input.input_type"/>
      </Property>
      <Property name="LastRadialAxisColor" id="7010.LastRadialAxisColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="7010.LastRadialAxisColor.range"/>
      </Property>
      <Property name="LastRadialAxisMajorTickSize" id="7010.LastRadialAxisMajorTickSize" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="7010.LastRadialAxisMajorTickSize.range"/>
      </Property>
      <Property name="LastRadialAxisMajorTickThickness" id="7010.LastRadialAxisMajorTickThickness" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="7010.LastRadialAxisMajorTickThickness.range"/>
      </Property>
      <Property name="LastRadialAxisTickRatioSize" id="7010.LastRadialAxisTickRatioSize" number_of_elements="1">
        <Element index="0" value="0.3"/>
        <Domain name="range" id="7010.LastRadialAxisTickRatioSize.range"/>
      </Property>
      <Property name="LastRadialAxisTickRatioThickness" id="7010.LastRadialAxisTickRatioThickness" number_of_elements="1">
        <Element index="0" value="0.5"/>
        <Domain name="range" id="7010.LastRadialAxisTickRatioThickness.range"/>
      </Property>
      <Property name="MaximumAngle" id="7010.MaximumAngle" number_of_elements="1">
        <Element index="0" value="90"/>
        <Domain name="range" id="7010.MaximumAngle.range"/>
      </Property>
      <Property name="MaximumRadius" id="7010.MaximumRadius" number_of_elements="1">
        <Element index="0" value="4.3147975082902095"/>
        <Domain name="range" id="7010.MaximumRadius.range"/>
      </Property>
      <Property name="MinimumAngle" id="7010.MinimumAngle" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="7010.MinimumAngle.range"/>
      </Property>
      <Property name="MinimumRadius" id="7010.MinimumRadius" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="7010.MinimumRadius.range"/>
      </Property>
      <Property name="NumberOfArcs" id="7010.NumberOfArcs" number_of_elements="1">
        <Element index="0" value="5"/>
        <Domain name="range" id="7010.NumberOfArcs.range"/>
      </Property>
      <Property name="NumberOfRadialAxes" id="7010.NumberOfRadialAxes" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="7010.NumberOfRadialAxes.range"/>
      </Property>
      <Property name="Orientation" id="7010.Orientation" number_of_elements="3">
        <Element index="0" value="0"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0"/>
      </Property>
      <Property name="OverallColor" id="7010.OverallColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="7010.OverallColor.range"/>
      </Property>
      <Property name="PolarArcResolutionPerDegree" id="7010.PolarArcResolutionPerDegree" number_of_elements="1">
        <Element index="0" value="0.2"/>
        <Domain name="range" id="7010.PolarArcResolutionPerDegree.range"/>
      </Property>
      <Property name="PolarArcsColor" id="7010.PolarArcsColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="7010.PolarArcsColor.range"/>
      </Property>
      <Property name="PolarArcsVisibility" id="7010.PolarArcsVisibility" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="7010.PolarArcsVisibility.bool"/>
      </Property>
      <Property name="PolarAxisColor" id="7010.PolarAxisColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="7010.PolarAxisColor.range"/>
      </Property>
      <Property name="PolarAxisMajorTickSize" id="7010.PolarAxisMajorTickSize" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="7010.PolarAxisMajorTickSize.range"/>
      </Property>
      <Property name="PolarAxisMajorTickThickness" id="7010.PolarAxisMajorTickThickness" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="7010.PolarAxisMajorTickThickness.range"/>
      </Property>
      <Property name="PolarAxisTickRatioSize" id="7010.PolarAxisTickRatioSize" number_of_elements="1">
        <Element index="0" value="0.3"/>
        <Domain name="range" id="7010.PolarAxisTickRatioSize.range"/>
      </Property>
      <Property name="PolarAxisTickRatioThickness" id="7010.PolarAxisTickRatioThickness" number_of_elements="1">
        <Element index="0" value="0.5"/>
        <Domain name="range" id="7010.PolarAxisTickRatioThickness.range"/>
      </Property>
      <Property name="PolarAxisTitle" id="7010.PolarAxisTitle" number_of_elements="1">
        <Element index="0" value="Radial Distance"/>
      </Property>
      <Property name="PolarAxisTitleLocation" id="7010.PolarAxisTitleLocation" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="7010.PolarAxisTitleLocation.enum">
          <Entry value="0" text="Bottom"/>
          <Entry value="1" text="Extern"/>
        </Domain>
      </Property>
      <Property name="PolarAxisTitleVisibility" id="7010.PolarAxisTitleVisibility" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="7010.PolarAxisTitleVisibility.bool"/>
      </Property>
      <Property name="PolarAxisVisibility" id="7010.PolarAxisVisibility" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="7010.PolarAxisVisibility.bool"/>
      </Property>
      <Property name="PolarExponentOffset" id="7010.PolarExponentOffset" number_of_elements="1">
        <Element index="0" value="5"/>
        <Domain name="range" id="7010.PolarExponentOffset.range"/>
      </Property>
      <Property name="PolarLabelExponentLocation" id="7010.PolarLabelExponentLocation" number_of_elements="1">
        <Element index="0" value="2"/>
        <Domain name="enum" id="7010.PolarLabelExponentLocation.enum">
          <Entry value="0" text="Bottom"/>
          <Entry value="1" text="Extern"/>
          <Entry value="2" text="Labels"/>
        </Domain>
      </Property>
      <Property name="PolarLabelFormat" id="7010.PolarLabelFormat" number_of_elements="1">
        <Element index="0" value="{:&#x3c;#6.3g}"/>
      </Property>
      <Property name="PolarLabelOffset" id="7010.PolarLabelOffset" number_of_elements="1">
        <Element index="0" value="10"/>
        <Domain name="range" id="7010.PolarLabelOffset.range"/>
      </Property>
      <Property name="PolarLabelVisibility" id="7010.PolarLabelVisibility" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="7010.PolarLabelVisibility.bool"/>
      </Property>
      <Property name="PolarTitleOffset" id="7010.PolarTitleOffset" number_of_elements="2">
        <Element index="0" value="20"/>
        <Element index="1" value="20"/>
        <Domain name="range" id="7010.PolarTitleOffset.range"/>
      </Property>
      <Property name="PolePosition" id="7010.PolePosition" number_of_elements="3">
        <Element index="0" value="0"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0"/>
      </Property>
      <Property name="Position" id="7010.Position" number_of_elements="3">
        <Element index="0" value="0"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0"/>
      </Property>
      <Property name="RadialAxesOriginToPolarAxis" id="7010.RadialAxesOriginToPolarAxis" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="7010.RadialAxesOriginToPolarAxis.bool"/>
      </Property>
      <Property name="RadialAxesVisibility" id="7010.RadialAxesVisibility" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="7010.RadialAxesVisibility.bool"/>
      </Property>
      <Property name="RadialLabelFormat" id="7010.RadialLabelFormat" number_of_elements="1">
        <Element index="0" value="{:&#x3c;#3.1f}"/>
      </Property>
      <Property name="RadialLabelLocation" id="7010.RadialLabelLocation" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="7010.RadialLabelLocation.enum">
          <Entry value="0" text="Bottom"/>
          <Entry value="1" text="Extern"/>
        </Domain>
      </Property>
      <Property name="RadialLabelOffset" id="7010.RadialLabelOffset" number_of_elements="2">
        <Element index="0" value="20"/>
        <Element index="1" value="0"/>
        <Domain name="range" id="7010.RadialLabelOffset.range"/>
      </Property>
      <Property name="RadialLabelVisibility" id="7010.RadialLabelVisibility" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="7010.RadialLabelVisibility.bool"/>
      </Property>
      <Property name="RadialUnitsVisibility" id="7010.RadialUnitsVisibility" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="7010.RadialUnitsVisibility.bool"/>
      </Property>
      <Property name="RasterizeText" id="7010.RasterizeText" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7010.RasterizeText.bool"/>
      </Property>
      <Property name="Ratio" id="7010.Ratio" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="7010.Ratio.range"/>
      </Property>
      <Property name="Scale" id="7010.Scale" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
      </Property>
      <Property name="ScreenSize" id="7010.ScreenSize" number_of_elements="1">
        <Element index="0" value="10"/>
        <Domain name="range" id="7010.ScreenSize.range"/>
      </Property>
      <Property name="SecondaryPolarArcsColor" id="7010.SecondaryPolarArcsColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="7010.SecondaryPolarArcsColor.range"/>
      </Property>
      <Property name="SecondaryRadialAxesColor" id="7010.SecondaryRadialAxesColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="7010.SecondaryRadialAxesColor.range"/>
      </Property>
      <Property name="SmallestVisiblePolarAngle" id="7010.SmallestVisiblePolarAngle" number_of_elements="1">
        <Element index="0" value="0.5"/>
        <Domain name="range" id="7010.SmallestVisiblePolarAngle.range"/>
      </Property>
      <Property name="TickLocation" id="7010.TickLocation" number_of_elements="1">
        <Element index="0" value="2"/>
        <Domain name="enum" id="7010.TickLocation.enum">
          <Entry value="0" text="Inside"/>
          <Entry value="1" text="Outside"/>
          <Entry value="2" text="Both"/>
        </Domain>
      </Property>
      <Property name="TickRatioRadiusSize" id="7010.TickRatioRadiusSize" number_of_elements="1">
        <Element index="0" value="0.02"/>
        <Domain name="range" id="7010.TickRatioRadiusSize.range"/>
      </Property>
      <Property name="Use2DMode" id="7010.Use2DMode" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7010.Use2DMode.bool"/>
      </Property>
      <Property name="UseLogAxis" id="7010.UseLogAxis" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7010.UseLogAxis.bool"/>
      </Property>
      <Property name="ViewAngleLODThreshold" id="7010.ViewAngleLODThreshold" number_of_elements="1">
        <Element index="0" value="0.7"/>
        <Domain name="range" id="7010.ViewAngleLODThreshold.range"/>
      </Property>
      <Property name="Visibility" id="7010.Visibility" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7010.Visibility.bool"/>
      </Property>
      <Property name="LastRadialAxisTextBold" id="7010.LastRadialAxisTextBold" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7010.LastRadialAxisTextBold.bool"/>
      </Property>
      <Property name="LastRadialAxisTextColor" id="7010.LastRadialAxisTextColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="7010.LastRadialAxisTextColor.range"/>
      </Property>
      <Property name="LastRadialAxisTextFontFamily" id="7010.LastRadialAxisTextFontFamily" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="7010.LastRadialAxisTextFontFamily.enum">
          <Entry value="0" text="Arial"/>
          <Entry value="1" text="Courier"/>
          <Entry value="2" text="Times"/>
          <Entry value="4" text="File"/>
        </Domain>
      </Property>
      <Property name="LastRadialAxisTextFontFile" id="7010.LastRadialAxisTextFontFile" number_of_elements="1">
        <Element index="0" value=""/>
      </Property>
      <Property name="LastRadialAxisTextFontSize" id="7010.LastRadialAxisTextFontSize" number_of_elements="1">
        <Element index="0" value="12"/>
        <Domain name="range" id="7010.LastRadialAxisTextFontSize.range"/>
      </Property>
      <Property name="LastRadialAxisTextItalic" id="7010.LastRadialAxisTextItalic" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7010.LastRadialAxisTextItalic.bool"/>
      </Property>
      <Property name="LastRadialAxisTextOpacity" id="7010.LastRadialAxisTextOpacity" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="7010.LastRadialAxisTextOpacity.range"/>
      </Property>
      <Property name="LastRadialAxisTextShadow" id="7010.LastRadialAxisTextShadow" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7010.LastRadialAxisTextShadow.bool"/>
      </Property>
      <Property name="PolarAxisLabelBold" id="7010.PolarAxisLabelBold" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7010.PolarAxisLabelBold.bool"/>
      </Property>
      <Property name="PolarAxisLabelColor" id="7010.PolarAxisLabelColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="7010.PolarAxisLabelColor.range"/>
      </Property>
      <Property name="PolarAxisLabelFontFamily" id="7010.PolarAxisLabelFontFamily" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="7010.PolarAxisLabelFontFamily.enum">
          <Entry value="0" text="Arial"/>
          <Entry value="1" text="Courier"/>
          <Entry value="2" text="Times"/>
          <Entry value="4" text="File"/>
        </Domain>
      </Property>
      <Property name="PolarAxisLabelFontFile" id="7010.PolarAxisLabelFontFile" number_of_elements="1">
        <Element index="0" value=""/>
      </Property>
      <Property name="PolarAxisLabelFontSize" id="7010.PolarAxisLabelFontSize" number_of_elements="1">
        <Element index="0" value="12"/>
        <Domain name="range" id="7010.PolarAxisLabelFontSize.range"/>
      </Property>
      <Property name="PolarAxisLabelItalic" id="7010.PolarAxisLabelItalic" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7010.PolarAxisLabelItalic.bool"/>
      </Property>
      <Property name="PolarAxisLabelOpacity" id="7010.PolarAxisLabelOpacity" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="7010.PolarAxisLabelOpacity.range"/>
      </Property>
      <Property name="PolarAxisLabelShadow" id="7010.PolarAxisLabelShadow" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7010.PolarAxisLabelShadow.bool"/>
      </Property>
      <Property name="PolarAxisTitleBold" id="7010.PolarAxisTitleBold" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7010.PolarAxisTitleBold.bool"/>
      </Property>
      <Property name="PolarAxisTitleColor" id="7010.PolarAxisTitleColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="7010.PolarAxisTitleColor.range"/>
      </Property>
      <Property name="PolarAxisTitleFontFamily" id="7010.PolarAxisTitleFontFamily" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="7010.PolarAxisTitleFontFamily.enum">
          <Entry value="0" text="Arial"/>
          <Entry value="1" text="Courier"/>
          <Entry value="2" text="Times"/>
          <Entry value="4" text="File"/>
        </Domain>
      </Property>
      <Property name="PolarAxisTitleFontFile" id="7010.PolarAxisTitleFontFile" number_of_elements="1">
        <Element index="0" value=""/>
      </Property>
      <Property name="PolarAxisTitleFontSize" id="7010.PolarAxisTitleFontSize" number_of_elements="1">
        <Element index="0" value="12"/>
        <Domain name="range" id="7010.PolarAxisTitleFontSize.range"/>
      </Property>
      <Property name="PolarAxisTitleItalic" id="7010.PolarAxisTitleItalic" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7010.PolarAxisTitleItalic.bool"/>
      </Property>
      <Property name="PolarAxisTitleOpacity" id="7010.PolarAxisTitleOpacity" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="7010.PolarAxisTitleOpacity.range"/>
      </Property>
      <Property name="PolarAxisTitleShadow" id="7010.PolarAxisTitleShadow" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7010.PolarAxisTitleShadow.bool"/>
      </Property>
      <Property name="SecondaryRadialAxesTextBold" id="7010.SecondaryRadialAxesTextBold" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7010.SecondaryRadialAxesTextBold.bool"/>
      </Property>
      <Property name="SecondaryRadialAxesTextColor" id="7010.SecondaryRadialAxesTextColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="7010.SecondaryRadialAxesTextColor.range"/>
      </Property>
      <Property name="SecondaryRadialAxesTextFontFamily" id="7010.SecondaryRadialAxesTextFontFamily" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="7010.SecondaryRadialAxesTextFontFamily.enum">
          <Entry value="0" text="Arial"/>
          <Entry value="1" text="Courier"/>
          <Entry value="2" text="Times"/>
          <Entry value="4" text="File"/>
        </Domain>
      </Property>
      <Property name="SecondaryRadialAxesTextFontFile" id="7010.SecondaryRadialAxesTextFontFile" number_of_elements="1">
        <Element index="0" value=""/>
      </Property>
      <Property name="SecondaryRadialAxesTextFontSize" id="7010.SecondaryRadialAxesTextFontSize" number_of_elements="1">
        <Element index="0" value="12"/>
        <Domain name="range" id="7010.SecondaryRadialAxesTextFontSize.range"/>
      </Property>
      <Property name="SecondaryRadialAxesTextItalic" id="7010.SecondaryRadialAxesTextItalic" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7010.SecondaryRadialAxesTextItalic.bool"/>
      </Property>
      <Property name="SecondaryRadialAxesTextOpacity" id="7010.SecondaryRadialAxesTextOpacity" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="7010.SecondaryRadialAxesTextOpacity.range"/>
      </Property>
      <Property name="SecondaryRadialAxesTextShadow" id="7010.SecondaryRadialAxesTextShadow" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7010.SecondaryRadialAxesTextShadow.bool"/>
      </Property>
    </Proxy>
    <Proxy group="piecewise_functions" type="PiecewiseFunction" id="7143" servers="21">
      <Property name="AllowDuplicateScalars" id="7143.AllowDuplicateScalars" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="7143.AllowDuplicateScalars.bool"/>
      </Property>
      <Property name="Points" id="7143.Points" number_of_elements="8">
        <Element index="0" value="1"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0.5"/>
        <Element index="3" value="0"/>
        <Element index="4" value="9245"/>
        <Element index="5" value="1"/>
        <Element index="6" value="0.5"/>
        <Element index="7" value="0"/>
      </Property>
      <Property name="ScalarRangeInitialized" id="7143.ScalarRangeInitialized" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="7143.ScalarRangeInitialized.bool"/>
      </Property>
      <Property name="UseLogScale" id="7143.UseLogScale" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7143.UseLogScale.bool"/>
      </Property>
    </Proxy>
    <Proxy group="extended_sources" type="Transform2" id="7189" servers="21">
      <Property name="Position" id="7189.Position" number_of_elements="3">
        <Element index="0" value="0"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0"/>
        <Domain name="range" id="7189.Position.range"/>
      </Property>
      <Property name="PositionInfo" id="7189.PositionInfo" number_of_elements="3">
        <Element index="0" value="0"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0"/>
      </Property>
      <Property name="Rotation" id="7189.Rotation" number_of_elements="3">
        <Element index="0" value="0"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0"/>
        <Domain name="range" id="7189.Rotation.range"/>
      </Property>
      <Property name="RotationInfo" id="7189.RotationInfo" number_of_elements="3">
        <Element index="0" value="0"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0"/>
      </Property>
      <Property name="Scale" id="7189.Scale" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="7189.Scale.range"/>
      </Property>
      <Property name="ScaleInfo" id="7189.ScaleInfo" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
      </Property>
    </Proxy>
    <Proxy group="representations" type="UnstructuredGridRepresentation" id="6919" servers="21">
      <Property name="DataAxesGrid" id="6919.DataAxesGrid" number_of_elements="1">
        <Proxy value="6697"/>
        <Domain name="proxy_list" id="6919.DataAxesGrid.proxy_list">
          <Proxy value="6697"/>
        </Domain>
      </Property>
      <Property name="Input" id="6919.Input" number_of_elements="1">
        <Proxy value="6577" output_port="0"/>
        <Domain name="input_array_cell" id="6919.Input.input_array_cell"/>
        <Domain name="input_array_point" id="6919.Input.input_array_point"/>
        <Domain name="input_type" id="6919.Input.input_type"/>
      </Property>
      <Property name="PolarAxes" id="6919.PolarAxes" number_of_elements="1">
        <Proxy value="6712"/>
        <Domain name="proxy_list" id="6919.PolarAxes.proxy_list">
          <Proxy value="6712"/>
        </Domain>
      </Property>
      <Property name="Representation" id="6919.Representation" number_of_elements="1">
        <Element index="0" value="Surface"/>
        <Domain name="list" id="6919.Representation.list">
          <String text="3D Glyphs"/>
          <String text="Feature Edges"/>
          <String text="Outline"/>
          <String text="Point Gaussian"/>
          <String text="Points"/>
          <String text="Surface"/>
          <String text="Surface LIC"/>
          <String text="Surface With Edges"/>
          <String text="Volume"/>
          <String text="Wireframe"/>
        </Domain>
      </Property>
      <Property name="RepresentationTypesInfo" id="6919.RepresentationTypesInfo" number_of_elements="10">
        <Element index="0" value="3D Glyphs"/>
        <Element index="1" value="Feature Edges"/>
        <Element index="2" value="Outline"/>
        <Element index="3" value="Point Gaussian"/>
        <Element index="4" value="Points"/>
        <Element index="5" value="Surface"/>
        <Element index="6" value="Surface LIC"/>
        <Element index="7" value="Surface With Edges"/>
        <Element index="8" value="Volume"/>
        <Element index="9" value="Wireframe"/>
      </Property>
      <Property name="Selection" id="6919.Selection">
        <Domain name="input_type" id="6919.Selection.input_type"/>
      </Property>
      <Property name="SelectionCellFieldDataArrayName" id="6919.SelectionCellFieldDataArrayName" number_of_elements="1">
        <Element index="0" value="ids"/>
        <Domain name="array_list" id="6919.SelectionCellFieldDataArrayName.array_list">
          <String text="ids"/>
          <String text="mixing_len"/>
          <String text="mu_t"/>
          <String text="object_id"/>
          <String text="power_density"/>
          <String text="pressure"/>
          <String text="vel"/>
        </Domain>
      </Property>
      <Property name="SelectionPointFieldDataArrayName" id="6919.SelectionPointFieldDataArrayName" number_of_elements="1">
        <Element index="0" value="ids"/>
        <Domain name="array_list" id="6919.SelectionPointFieldDataArrayName.array_list">
          <String text="ids"/>
        </Domain>
      </Property>
      <Property name="SelectionVisibility" id="6919.SelectionVisibility" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6919.SelectionVisibility.bool"/>
      </Property>
      <Property name="Visibility" id="6919.Visibility" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6919.Visibility.bool"/>
      </Property>
      <Property name="Ambient" id="6919.Ambient" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="6919.Ambient.range"/>
      </Property>
      <Property name="AmbientColor" id="6919.AmbientColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="6919.AmbientColor.range"/>
      </Property>
      <Property name="Anisotropy" id="6919.Anisotropy" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="6919.Anisotropy.range"/>
      </Property>
      <Property name="AnisotropyRotation" id="6919.AnisotropyRotation" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="6919.AnisotropyRotation.range"/>
      </Property>
      <Property name="AnisotropyTexture" id="6919.AnisotropyTexture">
        <Domain name="groups" id="6919.AnisotropyTexture.groups"/>
      </Property>
      <Property name="AntiAlias" id="6919.AntiAlias" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="6919.AntiAlias.range"/>
      </Property>
      <Property name="Assembly" id="6919.Assembly" number_of_elements="1">
        <Element index="0" value="Assembly"/>
        <Domain name="data_assembly" id="6919.Assembly.data_assembly">
          <String text="Hierarchy"/>
          <String text="Assembly"/>
        </Domain>
      </Property>
      <Property name="BackfaceAmbientColor" id="6919.BackfaceAmbientColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="6919.BackfaceAmbientColor.range"/>
      </Property>
      <Property name="BackfaceDiffuseColor" id="6919.BackfaceDiffuseColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="6919.BackfaceDiffuseColor.range"/>
      </Property>
      <Property name="BackfaceOpacity" id="6919.BackfaceOpacity" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="6919.BackfaceOpacity.range"/>
      </Property>
      <Property name="BackfaceRepresentation" id="6919.BackfaceRepresentation" number_of_elements="1">
        <Element index="0" value="400"/>
        <Domain name="enum" id="6919.BackfaceRepresentation.enum">
          <Entry value="400" text="Follow Frontface"/>
          <Entry value="401" text="Cull Backface"/>
          <Entry value="402" text="Cull Frontface"/>
          <Entry value="0" text="Points"/>
          <Entry value="1" text="Wireframe"/>
          <Entry value="2" text="Surface"/>
          <Entry value="3" text="Surface With Edges"/>
        </Domain>
      </Property>
      <Property name="BaseColorTexture" id="6919.BaseColorTexture">
        <Domain name="groups" id="6919.BaseColorTexture.groups"/>
      </Property>
      <Property name="BaseIOR" id="6919.BaseIOR" number_of_elements="1">
        <Element index="0" value="1.5"/>
        <Domain name="range" id="6919.BaseIOR.range"/>
      </Property>
      <Property name="BlockColorArrayNames" id="6919.BlockColorArrayNames">
        <Domain name="array_list" id="6919.BlockColorArrayNames.array_list"/>
      </Property>
      <Property name="BlockColors" id="6919.BlockColors">
        <Domain name="data_assembly" id="6919.BlockColors.data_assembly"/>
      </Property>
      <Property name="BlockColorsDistinctValues" id="6919.BlockColorsDistinctValues" number_of_elements="1">
        <Element index="0" value="12"/>
        <Domain name="range" id="6919.BlockColorsDistinctValues.range"/>
      </Property>
      <Property name="BlockInterpolateScalarsBeforeMappings" id="6919.BlockInterpolateScalarsBeforeMappings">
        <Domain name="data_assembly" id="6919.BlockInterpolateScalarsBeforeMappings.data_assembly"/>
      </Property>
      <Property name="BlockInterpolateScalarsBeforeMappingsGUI" id="6919.BlockInterpolateScalarsBeforeMappingsGUI" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6919.BlockInterpolateScalarsBeforeMappingsGUI.bool"/>
      </Property>
      <Property name="BlockLookupTables" id="6919.BlockLookupTables">
        <Domain name="groups" id="6919.BlockLookupTables.groups"/>
      </Property>
      <Property name="BlockMapScalars" id="6919.BlockMapScalars">
        <Domain name="data_assembly" id="6919.BlockMapScalars.data_assembly"/>
      </Property>
      <Property name="BlockMapScalarsGUI" id="6919.BlockMapScalarsGUI" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6919.BlockMapScalarsGUI.bool"/>
      </Property>
      <Property name="BlockOpacities" id="6919.BlockOpacities">
        <Domain name="data_assembly" id="6919.BlockOpacities.data_assembly"/>
      </Property>
      <Property name="BlockOpacitiesGUI" id="6919.BlockOpacitiesGUI" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="6919.BlockOpacitiesGUI.range"/>
      </Property>
      <Property name="BlockSelectors" id="6919.BlockSelectors" number_of_elements="1">
        <Element index="0" value="/"/>
        <Domain name="data_assembly" id="6919.BlockSelectors.data_assembly"/>
      </Property>
      <Property name="BlockUseSeparateColorMaps" id="6919.BlockUseSeparateColorMaps">
        <Domain name="data_assembly" id="6919.BlockUseSeparateColorMaps.data_assembly"/>
      </Property>
      <Property name="CoatColor" id="6919.CoatColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="6919.CoatColor.range"/>
      </Property>
      <Property name="CoatIOR" id="6919.CoatIOR" number_of_elements="1">
        <Element index="0" value="2"/>
        <Domain name="range" id="6919.CoatIOR.range"/>
      </Property>
      <Property name="CoatNormalScale" id="6919.CoatNormalScale" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="6919.CoatNormalScale.range"/>
      </Property>
      <Property name="CoatNormalTexture" id="6919.CoatNormalTexture">
        <Domain name="groups" id="6919.CoatNormalTexture.groups"/>
      </Property>
      <Property name="CoatRoughness" id="6919.CoatRoughness" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="6919.CoatRoughness.range"/>
      </Property>
      <Property name="CoatStrength" id="6919.CoatStrength" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="6919.CoatStrength.range"/>
      </Property>
      <Property name="ColorArrayName" id="6919.ColorArrayName" number_of_elements="5">
        <Element index="0" value=""/>
        <Element index="1" value=""/>
        <Element index="2" value=""/>
        <Element index="3" value="1"/>
        <Element index="4" value="vel"/>
        <Domain name="array_list" id="6919.ColorArrayName.array_list">
          <String text="ids"/>
          <String text="vtkCompositeIndex"/>
          <String text="ids"/>
          <String text="mixing_len"/>
          <String text="mu_t"/>
          <String text="object_id"/>
          <String text="power_density"/>
          <String text="pressure"/>
          <String text="vel"/>
          <String text="vtkCompositeIndex"/>
          <String text="max_vel"/>
          <String text="min_vel_z"/>
          <String text="vtkBlockColors"/>
        </Domain>
      </Property>
      <Property name="ColorByLODIndex" id="6919.ColorByLODIndex" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6919.ColorByLODIndex.bool"/>
      </Property>
      <Property name="ColorMode" id="6919.ColorMode" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="6919.ColorMode.enum">
          <Entry value="0" text="Blend"/>
          <Entry value="1" text="Multiply"/>
        </Domain>
      </Property>
      <Property name="CompositeStrategy" id="6919.CompositeStrategy" number_of_elements="1">
        <Element index="0" value="3"/>
        <Domain name="enum" id="6919.CompositeStrategy.enum">
          <Entry value="0" text="INPLACE"/>
          <Entry value="1" text="INPLACE DISJOINT"/>
          <Entry value="2" text="BALANCED"/>
          <Entry value="3" text="AUTO"/>
        </Domain>
      </Property>
      <Property name="ComputePointNormals" id="6919.ComputePointNormals" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6919.ComputePointNormals.bool"/>
      </Property>
      <Property name="CoordinateShiftScaleMethod" id="6919.CoordinateShiftScaleMethod" number_of_elements="1">
        <Element index="0" value="2"/>
        <Domain name="enum" id="6919.CoordinateShiftScaleMethod.enum">
          <Entry value="0" text="Disable"/>
          <Entry value="1" text="Auto Shift Scale"/>
          <Entry value="2" text="Always Auto Shift Scale"/>
          <Entry value="4" text="Auto Shift Only"/>
          <Entry value="5" text="Near Focal Plane Shift Scale"/>
          <Entry value="6" text="Focal Point Shift Scale"/>
        </Domain>
      </Property>
      <Property name="CoordinateSystem" id="6919.CoordinateSystem" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="6919.CoordinateSystem.enum">
          <Entry value="0" text="Navigable"/>
          <Entry value="1" text="Fixed"/>
        </Domain>
      </Property>
      <Property name="CustomShader" id="6919.CustomShader" number_of_elements="1">
        <Element index="0" value=" // This custom shader code define a gaussian blur&#xa; // Please take a look into vtkSMPointGaussianRepresentation.cxx&#xa; // for other custom shader examples&#xa; //VTK::Color::Impl&#xa;   float dist2 = dot(offsetVCVSOutput.xy,offsetVCVSOutput.xy);&#xa;   float gaussian = exp(-0.5*dist2);&#xa;   opacity = opacity*gaussian;&#xa;"/>
      </Property>
      <Property name="CustomTriangleScale" id="6919.CustomTriangleScale" number_of_elements="1">
        <Element index="0" value="3"/>
      </Property>
      <Property name="Diffuse" id="6919.Diffuse" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="6919.Diffuse.range"/>
      </Property>
      <Property name="DiffuseColor" id="6919.DiffuseColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="6919.DiffuseColor.range"/>
      </Property>
      <Property name="DisableLighting" id="6919.DisableLighting" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6919.DisableLighting.bool"/>
      </Property>
      <Property name="EdgeColor" id="6919.EdgeColor" number_of_elements="3">
        <Element index="0" value="0"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0.5"/>
        <Domain name="range" id="6919.EdgeColor.range"/>
      </Property>
      <Property name="EdgeOpacity" id="6919.EdgeOpacity" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="6919.EdgeOpacity.range"/>
      </Property>
      <Property name="EdgeTint" id="6919.EdgeTint" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="6919.EdgeTint.range"/>
      </Property>
      <Property name="Emissive" id="6919.Emissive" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6919.Emissive.bool"/>
      </Property>
      <Property name="EmissiveFactor" id="6919.EmissiveFactor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="6919.EmissiveFactor.range"/>
      </Property>
      <Property name="EmissiveTexture" id="6919.EmissiveTexture">
        <Domain name="groups" id="6919.EmissiveTexture.groups"/>
      </Property>
      <Property name="EnhanceContrast" id="6919.EnhanceContrast" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="6919.EnhanceContrast.enum">
          <Entry value="0" text="Off"/>
          <Entry value="1" text="LIC Only"/>
          <Entry value="4" text="LIC and Color"/>
          <Entry value="3" text="Color Only"/>
        </Domain>
      </Property>
      <Property name="EnhancedLIC" id="6919.EnhancedLIC" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6919.EnhancedLIC.bool"/>
      </Property>
      <Property name="FeatureAngle" id="6919.FeatureAngle" number_of_elements="1">
        <Element index="0" value="30"/>
        <Domain name="range" id="6919.FeatureAngle.range"/>
      </Property>
      <Property name="GaussianRadius" id="6919.GaussianRadius" number_of_elements="1">
        <Element index="0" value="0.021573987541451047"/>
        <Domain name="range" id="6919.GaussianRadius.range"/>
      </Property>
      <Property name="GenerateNoiseTexture" id="6919.GenerateNoiseTexture" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6919.GenerateNoiseTexture.bool"/>
      </Property>
      <Property name="GlyphTableIndexArray" id="6919.GlyphTableIndexArray" number_of_elements="1">
        <Element index="0" value="None"/>
        <Domain name="array_list" id="6919.GlyphTableIndexArray.array_list">
          <String text="None"/>
          <String text="ids"/>
          <String text="ids"/>
          <String text="mixing_len"/>
          <String text="mu_t"/>
          <String text="object_id"/>
          <String text="power_density"/>
          <String text="pressure"/>
          <String text="vel"/>
          <String text="Information Records"/>
          <String text="QA Records"/>
          <String text="max_vel"/>
          <String text="min_vel_z"/>
        </Domain>
      </Property>
      <Property name="GlyphType" id="6919.GlyphType" number_of_elements="1">
        <Proxy value="6734" output_port="0"/>
        <Domain name="input_type" id="6919.GlyphType.input_type"/>
        <Domain name="proxy_list" id="6919.GlyphType.proxy_list">
          <Proxy value="6734"/>
          <Proxy value="6745"/>
          <Proxy value="6756"/>
          <Proxy value="6767"/>
          <Proxy value="6778"/>
          <Proxy value="6789"/>
          <Proxy value="6800"/>
          <Proxy value="6811"/>
        </Domain>
      </Property>
      <Property name="HighColorContrastEnhancementFactor" id="6919.HighColorContrastEnhancementFactor" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="6919.HighColorContrastEnhancementFactor.range"/>
      </Property>
      <Property name="HighLICContrastEnhancementFactor" id="6919.HighLICContrastEnhancementFactor" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="6919.HighLICContrastEnhancementFactor.range"/>
      </Property>
      <Property name="ImpulseNoiseBackgroundValue" id="6919.ImpulseNoiseBackgroundValue" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="6919.ImpulseNoiseBackgroundValue.range"/>
      </Property>
      <Property name="ImpulseNoiseProbability" id="6919.ImpulseNoiseProbability" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="6919.ImpulseNoiseProbability.range"/>
      </Property>
      <Property name="InteractiveSelectionColor" id="6919.InteractiveSelectionColor" number_of_elements="3">
        <Element index="0" value="0.5"/>
        <Element index="1" value="0"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="6919.InteractiveSelectionColor.range"/>
      </Property>
      <Property name="InterpolateScalarsBeforeMapping" id="6919.InterpolateScalarsBeforeMapping" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6919.InterpolateScalarsBeforeMapping.bool"/>
      </Property>
      <Property name="InterpolateTextures" id="6919.InterpolateTextures" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6919.InterpolateTextures.bool"/>
      </Property>
      <Property name="Interpolation" id="6919.Interpolation" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="enum" id="6919.Interpolation.enum">
          <Entry value="0" text="Flat"/>
          <Entry value="1" text="Gouraud"/>
          <Entry value="3" text="PBR"/>
        </Domain>
      </Property>
      <Property name="LICIntensity" id="6919.LICIntensity" number_of_elements="1">
        <Element index="0" value="0.8"/>
        <Domain name="range" id="6919.LICIntensity.range"/>
      </Property>
      <Property name="LODValues" id="6919.LODValues">
        <Domain name="scalar_range" id="6919.LODValues.scalar_range"/>
      </Property>
      <Property name="LineWidth" id="6919.LineWidth" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="6919.LineWidth.range"/>
      </Property>
      <Property name="LookupTable" id="6919.LookupTable" number_of_elements="1">
        <Proxy value="6953"/>
        <Domain name="groups" id="6919.LookupTable.groups"/>
      </Property>
      <Property name="LowColorContrastEnhancementFactor" id="6919.LowColorContrastEnhancementFactor" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="6919.LowColorContrastEnhancementFactor.range"/>
      </Property>
      <Property name="LowLICContrastEnhancementFactor" id="6919.LowLICContrastEnhancementFactor" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="6919.LowLICContrastEnhancementFactor.range"/>
      </Property>
      <Property name="Luminosity" id="6919.Luminosity" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="6919.Luminosity.range"/>
      </Property>
      <Property name="MapModeBias" id="6919.MapModeBias" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="6919.MapModeBias.range"/>
      </Property>
      <Property name="MapScalars" id="6919.MapScalars" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6919.MapScalars.bool"/>
      </Property>
      <Property name="MaskColor" id="6919.MaskColor" number_of_elements="3">
        <Element index="0" value="0.5"/>
        <Element index="1" value="0.5"/>
        <Element index="2" value="0.5"/>
        <Domain name="range" id="6919.MaskColor.range"/>
      </Property>
      <Property name="MaskIntensity" id="6919.MaskIntensity" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="6919.MaskIntensity.range"/>
      </Property>
      <Property name="MaskOnSurface" id="6919.MaskOnSurface" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6919.MaskOnSurface.bool"/>
      </Property>
      <Property name="MaskThreshold" id="6919.MaskThreshold" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="6919.MaskThreshold.range"/>
      </Property>
      <Property name="Masking" id="6919.Masking" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6919.Masking.bool"/>
      </Property>
      <Property name="MatchBoundariesIgnoringCellOrder" id="6919.MatchBoundariesIgnoringCellOrder" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6919.MatchBoundariesIgnoringCellOrder.bool"/>
      </Property>
      <Property name="MaterialTexture" id="6919.MaterialTexture">
        <Domain name="groups" id="6919.MaterialTexture.groups"/>
      </Property>
      <Property name="MaxNoiseValue" id="6919.MaxNoiseValue" number_of_elements="1">
        <Element index="0" value="0.8"/>
        <Domain name="range" id="6919.MaxNoiseValue.range"/>
      </Property>
      <Property name="MeshVisibility" id="6919.MeshVisibility" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6919.MeshVisibility.bool"/>
      </Property>
      <Property name="Metallic" id="6919.Metallic" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="6919.Metallic.range"/>
      </Property>
      <Property name="MinNoiseValue" id="6919.MinNoiseValue" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="6919.MinNoiseValue.range"/>
      </Property>
      <Property name="MultiComponentsMapping" id="6919.MultiComponentsMapping" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6919.MultiComponentsMapping.bool"/>
      </Property>
      <Property name="NoiseGeneratorSeed" id="6919.NoiseGeneratorSeed" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="6919.NoiseGeneratorSeed.range"/>
      </Property>
      <Property name="NoiseGrainSize" id="6919.NoiseGrainSize" number_of_elements="1">
        <Element index="0" value="2"/>
        <Domain name="range" id="6919.NoiseGrainSize.range"/>
      </Property>
      <Property name="NoiseTextureSize" id="6919.NoiseTextureSize" number_of_elements="1">
        <Element index="0" value="128"/>
        <Domain name="range" id="6919.NoiseTextureSize.range"/>
      </Property>
      <Property name="NoiseType" id="6919.NoiseType" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="enum" id="6919.NoiseType.enum">
          <Entry value="0" text="uniform"/>
          <Entry value="1" text="Gaussian"/>
          <Entry value="2" text="Perlin"/>
        </Domain>
      </Property>
      <Property name="NonlinearSubdivisionLevel" id="6919.NonlinearSubdivisionLevel" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="6919.NonlinearSubdivisionLevel.range"/>
      </Property>
      <Property name="NormalScale" id="6919.NormalScale" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="6919.NormalScale.range"/>
      </Property>
      <Property name="NormalTexture" id="6919.NormalTexture">
        <Domain name="groups" id="6919.NormalTexture.groups"/>
      </Property>
      <Property name="NormalizeVectors" id="6919.NormalizeVectors" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6919.NormalizeVectors.bool"/>
      </Property>
      <Property name="NumberOfNoiseLevels" id="6919.NumberOfNoiseLevels" number_of_elements="1">
        <Element index="0" value="1024"/>
        <Domain name="range" id="6919.NumberOfNoiseLevels.range"/>
      </Property>
      <Property name="NumberOfSteps" id="6919.NumberOfSteps" number_of_elements="1">
        <Element index="0" value="40"/>
        <Domain name="range" id="6919.NumberOfSteps.range"/>
      </Property>
      <Property name="OSPRayMaterial" id="6919.OSPRayMaterial" number_of_elements="1">
        <Element index="0" value="None"/>
        <Domain name="string_list" id="6919.OSPRayMaterial.string_list">
          <String text="None"/>
        </Domain>
      </Property>
      <Property name="OSPRayScaleArray" id="6919.OSPRayScaleArray" number_of_elements="1">
        <Element index="0" value="ids"/>
        <Domain name="array_list" id="6919.OSPRayScaleArray.array_list">
          <String text="ids"/>
        </Domain>
      </Property>
      <Property name="OSPRayScaleFunction" id="6919.OSPRayScaleFunction" number_of_elements="1">
        <Proxy value="6890"/>
        <Domain name="groups" id="6919.OSPRayScaleFunction.groups"/>
        <Domain name="proxy_list" id="6919.OSPRayScaleFunction.proxy_list">
          <Proxy value="6890"/>
        </Domain>
      </Property>
      <Property name="OSPRayUseScaleArray" id="6919.OSPRayUseScaleArray" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="6919.OSPRayUseScaleArray.enum">
          <Entry value="-1" text="All Exact"/>
          <Entry value="0" text="All Approximate"/>
          <Entry value="1" text="Each Scaled"/>
          <Entry value="2" text="Each Exact"/>
        </Domain>
      </Property>
      <Property name="OcclusionStrength" id="6919.OcclusionStrength" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="6919.OcclusionStrength.range"/>
      </Property>
      <Property name="Opacity" id="6919.Opacity" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="6919.Opacity.range"/>
      </Property>
      <Property name="OpacityArray" id="6919.OpacityArray" number_of_elements="5">
        <Element index="0" value=""/>
        <Element index="1" value=""/>
        <Element index="2" value=""/>
        <Element index="3" value="0"/>
        <Element index="4" value="ids"/>
        <Domain name="array_list" id="6919.OpacityArray.array_list">
          <String text="ids"/>
        </Domain>
      </Property>
      <Property name="OpacityArrayComponent" id="6919.OpacityArrayComponent" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="comps" id="6919.OpacityArrayComponent.comps">
          <Entry value="0" text=""/>
        </Domain>
      </Property>
      <Property name="OpacityArrayName" id="6919.OpacityArrayName" number_of_elements="5">
        <Element index="0" value=""/>
        <Element index="1" value=""/>
        <Element index="2" value=""/>
        <Element index="3" value="0"/>
        <Element index="4" value="ids"/>
        <Domain name="array_list" id="6919.OpacityArrayName.array_list">
          <String text="ids"/>
          <String text="ids"/>
          <String text="mixing_len"/>
          <String text="mu_t"/>
          <String text="object_id"/>
          <String text="power_density"/>
          <String text="pressure"/>
          <String text="vel"/>
          <String text="Information Records"/>
          <String text="QA Records"/>
          <String text="max_vel"/>
          <String text="min_vel_z"/>
        </Domain>
      </Property>
      <Property name="OpacityByArray" id="6919.OpacityByArray" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6919.OpacityByArray.bool"/>
      </Property>
      <Property name="OpacityComponent" id="6919.OpacityComponent" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="comps" id="6919.OpacityComponent.comps">
          <Entry value="0" text=""/>
        </Domain>
      </Property>
      <Property name="OpacityTransferFunction" id="6919.OpacityTransferFunction" number_of_elements="1">
        <Proxy value="6844"/>
        <Domain name="proxy_list" id="6919.OpacityTransferFunction.proxy_list">
          <Proxy value="6844"/>
        </Domain>
      </Property>
      <Property name="Orient" id="6919.Orient" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6919.Orient.bool"/>
      </Property>
      <Property name="Orientation" id="6919.Orientation" number_of_elements="3">
        <Element index="0" value="0"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0"/>
        <Domain name="range" id="6919.Orientation.range"/>
      </Property>
      <Property name="OrientationMode" id="6919.OrientationMode" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="6919.OrientationMode.enum">
          <Entry value="0" text="Direction"/>
          <Entry value="1" text="Rotation"/>
          <Entry value="2" text="Quaternion"/>
        </Domain>
      </Property>
      <Property name="Origin" id="6919.Origin" number_of_elements="3">
        <Element index="0" value="0"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0"/>
        <Domain name="range" id="6919.Origin.range"/>
      </Property>
      <Property name="Pickable" id="6919.Pickable" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6919.Pickable.bool"/>
      </Property>
      <Property name="PointSize" id="6919.PointSize" number_of_elements="1">
        <Element index="0" value="2"/>
        <Domain name="range" id="6919.PointSize.range"/>
      </Property>
      <Property name="RenderLinesAsTubes" id="6919.RenderLinesAsTubes" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6919.RenderLinesAsTubes.bool"/>
      </Property>
      <Property name="RenderPointsAsSpheres" id="6919.RenderPointsAsSpheres" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6919.RenderPointsAsSpheres.bool"/>
      </Property>
      <Property name="RepeatTextures" id="6919.RepeatTextures" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6919.RepeatTextures.bool"/>
      </Property>
      <Property name="Roughness" id="6919.Roughness" number_of_elements="1">
        <Element index="0" value="0.3"/>
        <Domain name="range" id="6919.Roughness.range"/>
      </Property>
      <Property name="SamplingDimensions" id="6919.SamplingDimensions" number_of_elements="3">
        <Element index="0" value="128"/>
        <Element index="1" value="128"/>
        <Element index="2" value="128"/>
        <Domain name="range" id="6919.SamplingDimensions.range"/>
      </Property>
      <Property name="ScalarOpacityFunction" id="6919.ScalarOpacityFunction" number_of_elements="1">
        <Proxy value="6951"/>
        <Domain name="groups" id="6919.ScalarOpacityFunction.groups"/>
      </Property>
      <Property name="ScalarOpacityUnitDistance" id="6919.ScalarOpacityUnitDistance" number_of_elements="1">
        <Element index="0" value="0.20305243303660872"/>
        <Domain name="bounds" id="6919.ScalarOpacityUnitDistance.bounds"/>
      </Property>
      <Property name="Scale" id="6919.Scale" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="6919.Scale.range"/>
      </Property>
      <Property name="ScaleArrayComponent" id="6919.ScaleArrayComponent" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="comps" id="6919.ScaleArrayComponent.comps">
          <Entry value="0" text=""/>
        </Domain>
      </Property>
      <Property name="ScaleByArray" id="6919.ScaleByArray" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6919.ScaleByArray.bool"/>
      </Property>
      <Property name="ScaleFactor" id="6919.ScaleFactor" number_of_elements="1">
        <Element index="0" value="0.43147975082902096"/>
        <Domain name="bounds" id="6919.ScaleFactor.bounds"/>
        <Domain name="scalar_range" id="6919.ScaleFactor.scalar_range"/>
        <Domain name="vector_range" id="6919.ScaleFactor.vector_range"/>
      </Property>
      <Property name="ScaleMode" id="6919.ScaleMode" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="6919.ScaleMode.enum">
          <Entry value="0" text="No Data Scaling Off"/>
          <Entry value="1" text="Magnitude"/>
          <Entry value="2" text="Vector Components"/>
        </Domain>
      </Property>
      <Property name="ScaleTransferFunction" id="6919.ScaleTransferFunction" number_of_elements="1">
        <Proxy value="6845"/>
        <Domain name="proxy_list" id="6919.ScaleTransferFunction.proxy_list">
          <Proxy value="6845"/>
        </Domain>
      </Property>
      <Property name="Scaling" id="6919.Scaling" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6919.Scaling.bool"/>
      </Property>
      <Property name="SeamlessU" id="6919.SeamlessU" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6919.SeamlessU.bool"/>
      </Property>
      <Property name="SeamlessV" id="6919.SeamlessV" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6919.SeamlessV.bool"/>
      </Property>
      <Property name="SelectInputVectors" id="6919.SelectInputVectors" number_of_elements="5">
        <Element index="0" value=""/>
        <Element index="1" value=""/>
        <Element index="2" value=""/>
        <Element index="3" value=""/>
        <Element index="4" value=""/>
        <Domain name="array_list" id="6919.SelectInputVectors.array_list"/>
      </Property>
      <Property name="SelectMapper" id="6919.SelectMapper" number_of_elements="1">
        <Element index="0" value="Projected tetra"/>
        <Domain name="list" id="6919.SelectMapper.list">
          <String text="Projected tetra"/>
          <String text="Z sweep"/>
          <String text="Bunyk ray cast"/>
          <String text="Resample To Image"/>
        </Domain>
      </Property>
      <Property name="SelectMaskArray" id="6919.SelectMaskArray" number_of_elements="1">
        <Element index="0" value=""/>
      </Property>
      <Property name="SelectNormalArray" id="6919.SelectNormalArray" number_of_elements="1">
        <Element index="0" value="None"/>
        <Domain name="array_list" id="6919.SelectNormalArray.array_list">
          <String text="None"/>
        </Domain>
      </Property>
      <Property name="SelectOrientationVectors" id="6919.SelectOrientationVectors" number_of_elements="1">
        <Element index="0" value="None"/>
        <Domain name="array_list" id="6919.SelectOrientationVectors.array_list">
          <String text="None"/>
          <String text="vel"/>
        </Domain>
      </Property>
      <Property name="SelectScaleArray" id="6919.SelectScaleArray" number_of_elements="1">
        <Element index="0" value="None"/>
        <Domain name="array_list" id="6919.SelectScaleArray.array_list">
          <String text="None"/>
          <String text="ids"/>
          <String text="ids"/>
          <String text="mixing_len"/>
          <String text="mu_t"/>
          <String text="object_id"/>
          <String text="power_density"/>
          <String text="pressure"/>
          <String text="vel"/>
        </Domain>
      </Property>
      <Property name="SelectTCoordArray" id="6919.SelectTCoordArray" number_of_elements="1">
        <Element index="0" value="None"/>
        <Domain name="array_list" id="6919.SelectTCoordArray.array_list">
          <String text="None"/>
        </Domain>
      </Property>
      <Property name="SelectTangentArray" id="6919.SelectTangentArray" number_of_elements="1">
        <Element index="0" value="None"/>
        <Domain name="array_list" id="6919.SelectTangentArray.array_list">
          <String text="None"/>
        </Domain>
      </Property>
      <Property name="SelectedBlockSelectors" id="6919.SelectedBlockSelectors" number_of_elements="1">
        <Element index="0" value=""/>
        <Domain name="data_assembly" id="6919.SelectedBlockSelectors.data_assembly"/>
      </Property>
      <Property name="SelectionCellLabelBold" id="6919.SelectionCellLabelBold" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6919.SelectionCellLabelBold.bool"/>
      </Property>
      <Property name="SelectionCellLabelColor" id="6919.SelectionCellLabelColor" number_of_elements="3">
        <Element index="0" value="0"/>
        <Element index="1" value="1"/>
        <Element index="2" value="0"/>
        <Domain name="range" id="6919.SelectionCellLabelColor.range"/>
      </Property>
      <Property name="SelectionCellLabelFontFamily" id="6919.SelectionCellLabelFontFamily" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="6919.SelectionCellLabelFontFamily.enum">
          <Entry value="0" text="Arial"/>
          <Entry value="1" text="Courier"/>
          <Entry value="2" text="Times"/>
          <Entry value="4" text="File"/>
        </Domain>
      </Property>
      <Property name="SelectionCellLabelFontFile" id="6919.SelectionCellLabelFontFile" number_of_elements="1">
        <Element index="0" value=""/>
      </Property>
      <Property name="SelectionCellLabelFontSize" id="6919.SelectionCellLabelFontSize" number_of_elements="1">
        <Element index="0" value="18"/>
        <Domain name="range" id="6919.SelectionCellLabelFontSize.range"/>
      </Property>
      <Property name="SelectionCellLabelFormat" id="6919.SelectionCellLabelFormat" number_of_elements="1">
        <Element index="0" value=""/>
      </Property>
      <Property name="SelectionCellLabelItalic" id="6919.SelectionCellLabelItalic" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6919.SelectionCellLabelItalic.bool"/>
      </Property>
      <Property name="SelectionCellLabelJustification" id="6919.SelectionCellLabelJustification" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="6919.SelectionCellLabelJustification.enum">
          <Entry value="0" text="Left"/>
          <Entry value="1" text="Center"/>
          <Entry value="2" text="Right"/>
        </Domain>
      </Property>
      <Property name="SelectionCellLabelOpacity" id="6919.SelectionCellLabelOpacity" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="6919.SelectionCellLabelOpacity.range"/>
      </Property>
      <Property name="SelectionCellLabelShadow" id="6919.SelectionCellLabelShadow" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6919.SelectionCellLabelShadow.bool"/>
      </Property>
      <Property name="SelectionCellLabelVisibility" id="6919.SelectionCellLabelVisibility" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6919.SelectionCellLabelVisibility.bool"/>
      </Property>
      <Property name="SelectionColor" id="6919.SelectionColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="0"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="6919.SelectionColor.range"/>
      </Property>
      <Property name="SelectionLineWidth" id="6919.SelectionLineWidth" number_of_elements="1">
        <Element index="0" value="2"/>
        <Domain name="range" id="6919.SelectionLineWidth.range"/>
      </Property>
      <Property name="SelectionMaximumNumberOfLabels" id="6919.SelectionMaximumNumberOfLabels" number_of_elements="1">
        <Element index="0" value="100"/>
        <Domain name="range" id="6919.SelectionMaximumNumberOfLabels.range"/>
      </Property>
      <Property name="SelectionOpacity" id="6919.SelectionOpacity" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="6919.SelectionOpacity.range"/>
      </Property>
      <Property name="SelectionPointLabelBold" id="6919.SelectionPointLabelBold" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6919.SelectionPointLabelBold.bool"/>
      </Property>
      <Property name="SelectionPointLabelColor" id="6919.SelectionPointLabelColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="0"/>
        <Domain name="range" id="6919.SelectionPointLabelColor.range"/>
      </Property>
      <Property name="SelectionPointLabelFontFamily" id="6919.SelectionPointLabelFontFamily" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="6919.SelectionPointLabelFontFamily.enum">
          <Entry value="0" text="Arial"/>
          <Entry value="1" text="Courier"/>
          <Entry value="2" text="Times"/>
          <Entry value="4" text="File"/>
        </Domain>
      </Property>
      <Property name="SelectionPointLabelFontFile" id="6919.SelectionPointLabelFontFile" number_of_elements="1">
        <Element index="0" value=""/>
      </Property>
      <Property name="SelectionPointLabelFontSize" id="6919.SelectionPointLabelFontSize" number_of_elements="1">
        <Element index="0" value="18"/>
        <Domain name="range" id="6919.SelectionPointLabelFontSize.range"/>
      </Property>
      <Property name="SelectionPointLabelFormat" id="6919.SelectionPointLabelFormat" number_of_elements="1">
        <Element index="0" value=""/>
      </Property>
      <Property name="SelectionPointLabelItalic" id="6919.SelectionPointLabelItalic" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6919.SelectionPointLabelItalic.bool"/>
      </Property>
      <Property name="SelectionPointLabelJustification" id="6919.SelectionPointLabelJustification" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="6919.SelectionPointLabelJustification.enum">
          <Entry value="0" text="Left"/>
          <Entry value="1" text="Center"/>
          <Entry value="2" text="Right"/>
        </Domain>
      </Property>
      <Property name="SelectionPointLabelOpacity" id="6919.SelectionPointLabelOpacity" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="6919.SelectionPointLabelOpacity.range"/>
      </Property>
      <Property name="SelectionPointLabelShadow" id="6919.SelectionPointLabelShadow" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6919.SelectionPointLabelShadow.bool"/>
      </Property>
      <Property name="SelectionPointLabelVisibility" id="6919.SelectionPointLabelVisibility" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6919.SelectionPointLabelVisibility.bool"/>
      </Property>
      <Property name="SelectionPointSize" id="6919.SelectionPointSize" number_of_elements="1">
        <Element index="0" value="5"/>
        <Domain name="range" id="6919.SelectionPointSize.range"/>
      </Property>
      <Property name="SelectionRepresentation" id="6919.SelectionRepresentation" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="enum" id="6919.SelectionRepresentation.enum">
          <Entry value="0" text="Points"/>
          <Entry value="1" text="Wireframe"/>
          <Entry value="2" text="Surface"/>
        </Domain>
      </Property>
      <Property name="SelectionUseOutline" id="6919.SelectionUseOutline" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6919.SelectionUseOutline.bool"/>
      </Property>
      <Property name="SetScaleArray" id="6919.SetScaleArray" number_of_elements="5">
        <Element index="0" value=""/>
        <Element index="1" value=""/>
        <Element index="2" value=""/>
        <Element index="3" value="0"/>
        <Element index="4" value="ids"/>
        <Domain name="array_list" id="6919.SetScaleArray.array_list">
          <String text="ids"/>
        </Domain>
      </Property>
      <Property name="ShaderPreset" id="6919.ShaderPreset" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="enum" id="6919.ShaderPreset.enum">
          <Entry value="0" text="Gaussian Blur"/>
          <Entry value="1" text="Sphere"/>
          <Entry value="2" text="Black-edged circle"/>
          <Entry value="3" text="Plain circle"/>
          <Entry value="4" text="Triangle"/>
          <Entry value="5" text="Square Outline"/>
          <Entry value="6" text="Custom"/>
        </Domain>
      </Property>
      <Property name="ShaderReplacements" id="6919.ShaderReplacements" number_of_elements="1">
        <Element index="0" value=""/>
      </Property>
      <Property name="ShowTexturesOnBackface" id="6919.ShowTexturesOnBackface" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6919.ShowTexturesOnBackface.bool"/>
      </Property>
      <Property name="Specular" id="6919.Specular" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="6919.Specular.range"/>
      </Property>
      <Property name="SpecularColor" id="6919.SpecularColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="6919.SpecularColor.range"/>
      </Property>
      <Property name="SpecularPower" id="6919.SpecularPower" number_of_elements="1">
        <Element index="0" value="100"/>
        <Domain name="range" id="6919.SpecularPower.range"/>
      </Property>
      <Property name="Splitting" id="6919.Splitting" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6919.Splitting.bool"/>
      </Property>
      <Property name="StaticMode" id="6919.StaticMode" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6919.StaticMode.bool"/>
      </Property>
      <Property name="StepSize" id="6919.StepSize" number_of_elements="1">
        <Element index="0" value="0.25"/>
        <Domain name="range" id="6919.StepSize.range"/>
      </Property>
      <Property name="SuppressLOD" id="6919.SuppressLOD" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6919.SuppressLOD.bool"/>
      </Property>
      <Property name="Texture" id="6919.Texture">
        <Domain name="groups" id="6919.Texture.groups"/>
      </Property>
      <Property name="TextureTransform" id="6919.TextureTransform" number_of_elements="1">
        <Proxy value="6891"/>
        <Domain name="groups" id="6919.TextureTransform.groups"/>
        <Domain name="proxy_list" id="6919.TextureTransform.proxy_list">
          <Proxy value="6891"/>
        </Domain>
      </Property>
      <Property name="Translation" id="6919.Translation" number_of_elements="3">
        <Element index="0" value="0"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0"/>
        <Domain name="range" id="6919.Translation.range"/>
      </Property>
      <Property name="Triangulate" id="6919.Triangulate" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6919.Triangulate.bool"/>
      </Property>
      <Property name="UseCompositeGlyphTable" id="6919.UseCompositeGlyphTable" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6919.UseCompositeGlyphTable.bool"/>
      </Property>
      <Property name="UseDataPartitions" id="6919.UseDataPartitions" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6919.UseDataPartitions.bool"/>
      </Property>
      <Property name="UseFloatingPointFrameBuffer" id="6919.UseFloatingPointFrameBuffer" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6919.UseFloatingPointFrameBuffer.bool"/>
      </Property>
      <Property name="UseGlyphCullingAndLOD" id="6919.UseGlyphCullingAndLOD" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6919.UseGlyphCullingAndLOD.bool"/>
      </Property>
      <Property name="UseGlyphTable" id="6919.UseGlyphTable" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6919.UseGlyphTable.bool"/>
      </Property>
      <Property name="UseLICForLOD" id="6919.UseLICForLOD" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6919.UseLICForLOD.bool"/>
      </Property>
      <Property name="UseMipmapTextures" id="6919.UseMipmapTextures" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6919.UseMipmapTextures.bool"/>
      </Property>
      <Property name="UseNanColorForMissingArrays" id="6919.UseNanColorForMissingArrays" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6919.UseNanColorForMissingArrays.bool"/>
      </Property>
      <Property name="UseScaleFunction" id="6919.UseScaleFunction" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6919.UseScaleFunction.bool"/>
      </Property>
      <Property name="UseSeparateColorMap" id="6919.UseSeparateColorMap" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6919.UseSeparateColorMap.bool"/>
      </Property>
      <Property name="UseSeparateOpacityArray" id="6919.UseSeparateOpacityArray" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6919.UseSeparateOpacityArray.bool"/>
      </Property>
      <Property name="UseShaderReplacements" id="6919.UseShaderReplacements" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6919.UseShaderReplacements.bool"/>
      </Property>
      <Property name="UserTransform" id="6919.UserTransform" number_of_elements="16">
        <Element index="0" value="1"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0"/>
        <Element index="3" value="0"/>
        <Element index="4" value="0"/>
        <Element index="5" value="1"/>
        <Element index="6" value="0"/>
        <Element index="7" value="0"/>
        <Element index="8" value="0"/>
        <Element index="9" value="0"/>
        <Element index="10" value="1"/>
        <Element index="11" value="0"/>
        <Element index="12" value="0"/>
        <Element index="13" value="0"/>
        <Element index="14" value="0"/>
        <Element index="15" value="1"/>
      </Property>
      <Property name="WriteLog" id="6919.WriteLog" number_of_elements="1">
        <Element index="0" value=""/>
      </Property>
    </Proxy>
    <Proxy group="representations" type="UnstructuredGridRepresentation" id="7217" servers="21">
      <Property name="DataAxesGrid" id="7217.DataAxesGrid" number_of_elements="1">
        <Proxy value="6995"/>
        <Domain name="proxy_list" id="7217.DataAxesGrid.proxy_list">
          <Proxy value="6995"/>
        </Domain>
      </Property>
      <Property name="Input" id="7217.Input" number_of_elements="1">
        <Proxy value="6975" output_port="0"/>
        <Domain name="input_array_cell" id="7217.Input.input_array_cell"/>
        <Domain name="input_array_point" id="7217.Input.input_array_point"/>
        <Domain name="input_type" id="7217.Input.input_type"/>
      </Property>
      <Property name="PolarAxes" id="7217.PolarAxes" number_of_elements="1">
        <Proxy value="7010"/>
        <Domain name="proxy_list" id="7217.PolarAxes.proxy_list">
          <Proxy value="7010"/>
        </Domain>
      </Property>
      <Property name="Representation" id="7217.Representation" number_of_elements="1">
        <Element index="0" value="Surface"/>
        <Domain name="list" id="7217.Representation.list">
          <String text="3D Glyphs"/>
          <String text="Feature Edges"/>
          <String text="Outline"/>
          <String text="Point Gaussian"/>
          <String text="Points"/>
          <String text="Surface"/>
          <String text="Surface LIC"/>
          <String text="Surface With Edges"/>
          <String text="Volume"/>
          <String text="Wireframe"/>
        </Domain>
      </Property>
      <Property name="RepresentationTypesInfo" id="7217.RepresentationTypesInfo" number_of_elements="10">
        <Element index="0" value="3D Glyphs"/>
        <Element index="1" value="Feature Edges"/>
        <Element index="2" value="Outline"/>
        <Element index="3" value="Point Gaussian"/>
        <Element index="4" value="Points"/>
        <Element index="5" value="Surface"/>
        <Element index="6" value="Surface LIC"/>
        <Element index="7" value="Surface With Edges"/>
        <Element index="8" value="Volume"/>
        <Element index="9" value="Wireframe"/>
      </Property>
      <Property name="Selection" id="7217.Selection">
        <Domain name="input_type" id="7217.Selection.input_type"/>
      </Property>
      <Property name="SelectionCellFieldDataArrayName" id="7217.SelectionCellFieldDataArrayName" number_of_elements="1">
        <Element index="0" value="ids"/>
        <Domain name="array_list" id="7217.SelectionCellFieldDataArrayName.array_list">
          <String text="ids"/>
          <String text="mixing_len"/>
          <String text="mu_t"/>
          <String text="object_id"/>
          <String text="power_density"/>
          <String text="pressure"/>
          <String text="vel"/>
        </Domain>
      </Property>
      <Property name="SelectionPointFieldDataArrayName" id="7217.SelectionPointFieldDataArrayName" number_of_elements="1">
        <Element index="0" value="ids"/>
        <Domain name="array_list" id="7217.SelectionPointFieldDataArrayName.array_list">
          <String text="ids"/>
        </Domain>
      </Property>
      <Property name="SelectionVisibility" id="7217.SelectionVisibility" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="7217.SelectionVisibility.bool"/>
      </Property>
      <Property name="Visibility" id="7217.Visibility" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="7217.Visibility.bool"/>
      </Property>
      <Property name="Ambient" id="7217.Ambient" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="7217.Ambient.range"/>
      </Property>
      <Property name="AmbientColor" id="7217.AmbientColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="7217.AmbientColor.range"/>
      </Property>
      <Property name="Anisotropy" id="7217.Anisotropy" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="7217.Anisotropy.range"/>
      </Property>
      <Property name="AnisotropyRotation" id="7217.AnisotropyRotation" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="7217.AnisotropyRotation.range"/>
      </Property>
      <Property name="AnisotropyTexture" id="7217.AnisotropyTexture">
        <Domain name="groups" id="7217.AnisotropyTexture.groups"/>
      </Property>
      <Property name="AntiAlias" id="7217.AntiAlias" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="7217.AntiAlias.range"/>
      </Property>
      <Property name="Assembly" id="7217.Assembly" number_of_elements="1">
        <Element index="0" value="Assembly"/>
        <Domain name="data_assembly" id="7217.Assembly.data_assembly">
          <String text="Hierarchy"/>
          <String text="Assembly"/>
        </Domain>
      </Property>
      <Property name="BackfaceAmbientColor" id="7217.BackfaceAmbientColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="7217.BackfaceAmbientColor.range"/>
      </Property>
      <Property name="BackfaceDiffuseColor" id="7217.BackfaceDiffuseColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="7217.BackfaceDiffuseColor.range"/>
      </Property>
      <Property name="BackfaceOpacity" id="7217.BackfaceOpacity" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="7217.BackfaceOpacity.range"/>
      </Property>
      <Property name="BackfaceRepresentation" id="7217.BackfaceRepresentation" number_of_elements="1">
        <Element index="0" value="400"/>
        <Domain name="enum" id="7217.BackfaceRepresentation.enum">
          <Entry value="400" text="Follow Frontface"/>
          <Entry value="401" text="Cull Backface"/>
          <Entry value="402" text="Cull Frontface"/>
          <Entry value="0" text="Points"/>
          <Entry value="1" text="Wireframe"/>
          <Entry value="2" text="Surface"/>
          <Entry value="3" text="Surface With Edges"/>
        </Domain>
      </Property>
      <Property name="BaseColorTexture" id="7217.BaseColorTexture">
        <Domain name="groups" id="7217.BaseColorTexture.groups"/>
      </Property>
      <Property name="BaseIOR" id="7217.BaseIOR" number_of_elements="1">
        <Element index="0" value="1.5"/>
        <Domain name="range" id="7217.BaseIOR.range"/>
      </Property>
      <Property name="BlockColorArrayNames" id="7217.BlockColorArrayNames">
        <Domain name="array_list" id="7217.BlockColorArrayNames.array_list"/>
      </Property>
      <Property name="BlockColors" id="7217.BlockColors">
        <Domain name="data_assembly" id="7217.BlockColors.data_assembly"/>
      </Property>
      <Property name="BlockColorsDistinctValues" id="7217.BlockColorsDistinctValues" number_of_elements="1">
        <Element index="0" value="12"/>
        <Domain name="range" id="7217.BlockColorsDistinctValues.range"/>
      </Property>
      <Property name="BlockInterpolateScalarsBeforeMappings" id="7217.BlockInterpolateScalarsBeforeMappings">
        <Domain name="data_assembly" id="7217.BlockInterpolateScalarsBeforeMappings.data_assembly"/>
      </Property>
      <Property name="BlockInterpolateScalarsBeforeMappingsGUI" id="7217.BlockInterpolateScalarsBeforeMappingsGUI" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="7217.BlockInterpolateScalarsBeforeMappingsGUI.bool"/>
      </Property>
      <Property name="BlockLookupTables" id="7217.BlockLookupTables">
        <Domain name="groups" id="7217.BlockLookupTables.groups"/>
      </Property>
      <Property name="BlockMapScalars" id="7217.BlockMapScalars">
        <Domain name="data_assembly" id="7217.BlockMapScalars.data_assembly"/>
      </Property>
      <Property name="BlockMapScalarsGUI" id="7217.BlockMapScalarsGUI" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="7217.BlockMapScalarsGUI.bool"/>
      </Property>
      <Property name="BlockOpacities" id="7217.BlockOpacities">
        <Domain name="data_assembly" id="7217.BlockOpacities.data_assembly"/>
      </Property>
      <Property name="BlockOpacitiesGUI" id="7217.BlockOpacitiesGUI" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="7217.BlockOpacitiesGUI.range"/>
      </Property>
      <Property name="BlockSelectors" id="7217.BlockSelectors" number_of_elements="1">
        <Element index="0" value="/"/>
        <Domain name="data_assembly" id="7217.BlockSelectors.data_assembly"/>
      </Property>
      <Property name="BlockUseSeparateColorMaps" id="7217.BlockUseSeparateColorMaps">
        <Domain name="data_assembly" id="7217.BlockUseSeparateColorMaps.data_assembly"/>
      </Property>
      <Property name="CoatColor" id="7217.CoatColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="7217.CoatColor.range"/>
      </Property>
      <Property name="CoatIOR" id="7217.CoatIOR" number_of_elements="1">
        <Element index="0" value="2"/>
        <Domain name="range" id="7217.CoatIOR.range"/>
      </Property>
      <Property name="CoatNormalScale" id="7217.CoatNormalScale" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="7217.CoatNormalScale.range"/>
      </Property>
      <Property name="CoatNormalTexture" id="7217.CoatNormalTexture">
        <Domain name="groups" id="7217.CoatNormalTexture.groups"/>
      </Property>
      <Property name="CoatRoughness" id="7217.CoatRoughness" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="7217.CoatRoughness.range"/>
      </Property>
      <Property name="CoatStrength" id="7217.CoatStrength" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="7217.CoatStrength.range"/>
      </Property>
      <Property name="ColorArrayName" id="7217.ColorArrayName" number_of_elements="5">
        <Element index="0" value=""/>
        <Element index="1" value=""/>
        <Element index="2" value=""/>
        <Element index="3" value="1"/>
        <Element index="4" value="vel"/>
        <Domain name="array_list" id="7217.ColorArrayName.array_list">
          <String text="ids"/>
          <String text="vtkCompositeIndex"/>
          <String text="ids"/>
          <String text="mixing_len"/>
          <String text="mu_t"/>
          <String text="object_id"/>
          <String text="power_density"/>
          <String text="pressure"/>
          <String text="vel"/>
          <String text="vtkCompositeIndex"/>
          <String text="max_vel"/>
          <String text="min_vel_z"/>
          <String text="vtkBlockColors"/>
        </Domain>
      </Property>
      <Property name="ColorByLODIndex" id="7217.ColorByLODIndex" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7217.ColorByLODIndex.bool"/>
      </Property>
      <Property name="ColorMode" id="7217.ColorMode" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="7217.ColorMode.enum">
          <Entry value="0" text="Blend"/>
          <Entry value="1" text="Multiply"/>
        </Domain>
      </Property>
      <Property name="CompositeStrategy" id="7217.CompositeStrategy" number_of_elements="1">
        <Element index="0" value="3"/>
        <Domain name="enum" id="7217.CompositeStrategy.enum">
          <Entry value="0" text="INPLACE"/>
          <Entry value="1" text="INPLACE DISJOINT"/>
          <Entry value="2" text="BALANCED"/>
          <Entry value="3" text="AUTO"/>
        </Domain>
      </Property>
      <Property name="ComputePointNormals" id="7217.ComputePointNormals" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7217.ComputePointNormals.bool"/>
      </Property>
      <Property name="CoordinateShiftScaleMethod" id="7217.CoordinateShiftScaleMethod" number_of_elements="1">
        <Element index="0" value="2"/>
        <Domain name="enum" id="7217.CoordinateShiftScaleMethod.enum">
          <Entry value="0" text="Disable"/>
          <Entry value="1" text="Auto Shift Scale"/>
          <Entry value="2" text="Always Auto Shift Scale"/>
          <Entry value="4" text="Auto Shift Only"/>
          <Entry value="5" text="Near Focal Plane Shift Scale"/>
          <Entry value="6" text="Focal Point Shift Scale"/>
        </Domain>
      </Property>
      <Property name="CoordinateSystem" id="7217.CoordinateSystem" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="7217.CoordinateSystem.enum">
          <Entry value="0" text="Navigable"/>
          <Entry value="1" text="Fixed"/>
        </Domain>
      </Property>
      <Property name="CustomShader" id="7217.CustomShader" number_of_elements="1">
        <Element index="0" value=" // This custom shader code define a gaussian blur&#xa; // Please take a look into vtkSMPointGaussianRepresentation.cxx&#xa; // for other custom shader examples&#xa; //VTK::Color::Impl&#xa;   float dist2 = dot(offsetVCVSOutput.xy,offsetVCVSOutput.xy);&#xa;   float gaussian = exp(-0.5*dist2);&#xa;   opacity = opacity*gaussian;&#xa;"/>
      </Property>
      <Property name="CustomTriangleScale" id="7217.CustomTriangleScale" number_of_elements="1">
        <Element index="0" value="3"/>
      </Property>
      <Property name="Diffuse" id="7217.Diffuse" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="7217.Diffuse.range"/>
      </Property>
      <Property name="DiffuseColor" id="7217.DiffuseColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="7217.DiffuseColor.range"/>
      </Property>
      <Property name="DisableLighting" id="7217.DisableLighting" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7217.DisableLighting.bool"/>
      </Property>
      <Property name="EdgeColor" id="7217.EdgeColor" number_of_elements="3">
        <Element index="0" value="0"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0.5"/>
        <Domain name="range" id="7217.EdgeColor.range"/>
      </Property>
      <Property name="EdgeOpacity" id="7217.EdgeOpacity" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="7217.EdgeOpacity.range"/>
      </Property>
      <Property name="EdgeTint" id="7217.EdgeTint" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="7217.EdgeTint.range"/>
      </Property>
      <Property name="Emissive" id="7217.Emissive" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7217.Emissive.bool"/>
      </Property>
      <Property name="EmissiveFactor" id="7217.EmissiveFactor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="7217.EmissiveFactor.range"/>
      </Property>
      <Property name="EmissiveTexture" id="7217.EmissiveTexture">
        <Domain name="groups" id="7217.EmissiveTexture.groups"/>
      </Property>
      <Property name="EnhanceContrast" id="7217.EnhanceContrast" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="7217.EnhanceContrast.enum">
          <Entry value="0" text="Off"/>
          <Entry value="1" text="LIC Only"/>
          <Entry value="4" text="LIC and Color"/>
          <Entry value="3" text="Color Only"/>
        </Domain>
      </Property>
      <Property name="EnhancedLIC" id="7217.EnhancedLIC" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="7217.EnhancedLIC.bool"/>
      </Property>
      <Property name="FeatureAngle" id="7217.FeatureAngle" number_of_elements="1">
        <Element index="0" value="30"/>
        <Domain name="range" id="7217.FeatureAngle.range"/>
      </Property>
      <Property name="GaussianRadius" id="7217.GaussianRadius" number_of_elements="1">
        <Element index="0" value="0.021573987541451047"/>
        <Domain name="range" id="7217.GaussianRadius.range"/>
      </Property>
      <Property name="GenerateNoiseTexture" id="7217.GenerateNoiseTexture" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7217.GenerateNoiseTexture.bool"/>
      </Property>
      <Property name="GlyphTableIndexArray" id="7217.GlyphTableIndexArray" number_of_elements="1">
        <Element index="0" value="None"/>
        <Domain name="array_list" id="7217.GlyphTableIndexArray.array_list">
          <String text="None"/>
          <String text="ids"/>
          <String text="ids"/>
          <String text="mixing_len"/>
          <String text="mu_t"/>
          <String text="object_id"/>
          <String text="power_density"/>
          <String text="pressure"/>
          <String text="vel"/>
          <String text="Information Records"/>
          <String text="QA Records"/>
          <String text="max_vel"/>
          <String text="min_vel_z"/>
        </Domain>
      </Property>
      <Property name="GlyphType" id="7217.GlyphType" number_of_elements="1">
        <Proxy value="7032" output_port="0"/>
        <Domain name="input_type" id="7217.GlyphType.input_type"/>
        <Domain name="proxy_list" id="7217.GlyphType.proxy_list">
          <Proxy value="7032"/>
          <Proxy value="7043"/>
          <Proxy value="7054"/>
          <Proxy value="7065"/>
          <Proxy value="7076"/>
          <Proxy value="7087"/>
          <Proxy value="7098"/>
          <Proxy value="7109"/>
        </Domain>
      </Property>
      <Property name="HighColorContrastEnhancementFactor" id="7217.HighColorContrastEnhancementFactor" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="7217.HighColorContrastEnhancementFactor.range"/>
      </Property>
      <Property name="HighLICContrastEnhancementFactor" id="7217.HighLICContrastEnhancementFactor" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="7217.HighLICContrastEnhancementFactor.range"/>
      </Property>
      <Property name="ImpulseNoiseBackgroundValue" id="7217.ImpulseNoiseBackgroundValue" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="7217.ImpulseNoiseBackgroundValue.range"/>
      </Property>
      <Property name="ImpulseNoiseProbability" id="7217.ImpulseNoiseProbability" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="7217.ImpulseNoiseProbability.range"/>
      </Property>
      <Property name="InteractiveSelectionColor" id="7217.InteractiveSelectionColor" number_of_elements="3">
        <Element index="0" value="0.5"/>
        <Element index="1" value="0"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="7217.InteractiveSelectionColor.range"/>
      </Property>
      <Property name="InterpolateScalarsBeforeMapping" id="7217.InterpolateScalarsBeforeMapping" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="7217.InterpolateScalarsBeforeMapping.bool"/>
      </Property>
      <Property name="InterpolateTextures" id="7217.InterpolateTextures" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7217.InterpolateTextures.bool"/>
      </Property>
      <Property name="Interpolation" id="7217.Interpolation" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="enum" id="7217.Interpolation.enum">
          <Entry value="0" text="Flat"/>
          <Entry value="1" text="Gouraud"/>
          <Entry value="3" text="PBR"/>
        </Domain>
      </Property>
      <Property name="LICIntensity" id="7217.LICIntensity" number_of_elements="1">
        <Element index="0" value="0.8"/>
        <Domain name="range" id="7217.LICIntensity.range"/>
      </Property>
      <Property name="LODValues" id="7217.LODValues">
        <Domain name="scalar_range" id="7217.LODValues.scalar_range"/>
      </Property>
      <Property name="LineWidth" id="7217.LineWidth" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="7217.LineWidth.range"/>
      </Property>
      <Property name="LookupTable" id="7217.LookupTable" number_of_elements="1">
        <Proxy value="6953"/>
        <Domain name="groups" id="7217.LookupTable.groups"/>
      </Property>
      <Property name="LowColorContrastEnhancementFactor" id="7217.LowColorContrastEnhancementFactor" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="7217.LowColorContrastEnhancementFactor.range"/>
      </Property>
      <Property name="LowLICContrastEnhancementFactor" id="7217.LowLICContrastEnhancementFactor" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="7217.LowLICContrastEnhancementFactor.range"/>
      </Property>
      <Property name="Luminosity" id="7217.Luminosity" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="7217.Luminosity.range"/>
      </Property>
      <Property name="MapModeBias" id="7217.MapModeBias" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="7217.MapModeBias.range"/>
      </Property>
      <Property name="MapScalars" id="7217.MapScalars" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="7217.MapScalars.bool"/>
      </Property>
      <Property name="MaskColor" id="7217.MaskColor" number_of_elements="3">
        <Element index="0" value="0.5"/>
        <Element index="1" value="0.5"/>
        <Element index="2" value="0.5"/>
        <Domain name="range" id="7217.MaskColor.range"/>
      </Property>
      <Property name="MaskIntensity" id="7217.MaskIntensity" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="7217.MaskIntensity.range"/>
      </Property>
      <Property name="MaskOnSurface" id="7217.MaskOnSurface" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="7217.MaskOnSurface.bool"/>
      </Property>
      <Property name="MaskThreshold" id="7217.MaskThreshold" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="7217.MaskThreshold.range"/>
      </Property>
      <Property name="Masking" id="7217.Masking" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7217.Masking.bool"/>
      </Property>
      <Property name="MatchBoundariesIgnoringCellOrder" id="7217.MatchBoundariesIgnoringCellOrder" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7217.MatchBoundariesIgnoringCellOrder.bool"/>
      </Property>
      <Property name="MaterialTexture" id="7217.MaterialTexture">
        <Domain name="groups" id="7217.MaterialTexture.groups"/>
      </Property>
      <Property name="MaxNoiseValue" id="7217.MaxNoiseValue" number_of_elements="1">
        <Element index="0" value="0.8"/>
        <Domain name="range" id="7217.MaxNoiseValue.range"/>
      </Property>
      <Property name="MeshVisibility" id="7217.MeshVisibility" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7217.MeshVisibility.bool"/>
      </Property>
      <Property name="Metallic" id="7217.Metallic" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="7217.Metallic.range"/>
      </Property>
      <Property name="MinNoiseValue" id="7217.MinNoiseValue" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="7217.MinNoiseValue.range"/>
      </Property>
      <Property name="MultiComponentsMapping" id="7217.MultiComponentsMapping" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7217.MultiComponentsMapping.bool"/>
      </Property>
      <Property name="NoiseGeneratorSeed" id="7217.NoiseGeneratorSeed" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="7217.NoiseGeneratorSeed.range"/>
      </Property>
      <Property name="NoiseGrainSize" id="7217.NoiseGrainSize" number_of_elements="1">
        <Element index="0" value="2"/>
        <Domain name="range" id="7217.NoiseGrainSize.range"/>
      </Property>
      <Property name="NoiseTextureSize" id="7217.NoiseTextureSize" number_of_elements="1">
        <Element index="0" value="128"/>
        <Domain name="range" id="7217.NoiseTextureSize.range"/>
      </Property>
      <Property name="NoiseType" id="7217.NoiseType" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="enum" id="7217.NoiseType.enum">
          <Entry value="0" text="uniform"/>
          <Entry value="1" text="Gaussian"/>
          <Entry value="2" text="Perlin"/>
        </Domain>
      </Property>
      <Property name="NonlinearSubdivisionLevel" id="7217.NonlinearSubdivisionLevel" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="7217.NonlinearSubdivisionLevel.range"/>
      </Property>
      <Property name="NormalScale" id="7217.NormalScale" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="7217.NormalScale.range"/>
      </Property>
      <Property name="NormalTexture" id="7217.NormalTexture">
        <Domain name="groups" id="7217.NormalTexture.groups"/>
      </Property>
      <Property name="NormalizeVectors" id="7217.NormalizeVectors" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="7217.NormalizeVectors.bool"/>
      </Property>
      <Property name="NumberOfNoiseLevels" id="7217.NumberOfNoiseLevels" number_of_elements="1">
        <Element index="0" value="1024"/>
        <Domain name="range" id="7217.NumberOfNoiseLevels.range"/>
      </Property>
      <Property name="NumberOfSteps" id="7217.NumberOfSteps" number_of_elements="1">
        <Element index="0" value="40"/>
        <Domain name="range" id="7217.NumberOfSteps.range"/>
      </Property>
      <Property name="OSPRayMaterial" id="7217.OSPRayMaterial" number_of_elements="1">
        <Element index="0" value="None"/>
        <Domain name="string_list" id="7217.OSPRayMaterial.string_list">
          <String text="None"/>
        </Domain>
      </Property>
      <Property name="OSPRayScaleArray" id="7217.OSPRayScaleArray" number_of_elements="1">
        <Element index="0" value="ids"/>
        <Domain name="array_list" id="7217.OSPRayScaleArray.array_list">
          <String text="ids"/>
        </Domain>
      </Property>
      <Property name="OSPRayScaleFunction" id="7217.OSPRayScaleFunction" number_of_elements="1">
        <Proxy value="7188"/>
        <Domain name="groups" id="7217.OSPRayScaleFunction.groups"/>
        <Domain name="proxy_list" id="7217.OSPRayScaleFunction.proxy_list">
          <Proxy value="7188"/>
        </Domain>
      </Property>
      <Property name="OSPRayUseScaleArray" id="7217.OSPRayUseScaleArray" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="7217.OSPRayUseScaleArray.enum">
          <Entry value="-1" text="All Exact"/>
          <Entry value="0" text="All Approximate"/>
          <Entry value="1" text="Each Scaled"/>
          <Entry value="2" text="Each Exact"/>
        </Domain>
      </Property>
      <Property name="OcclusionStrength" id="7217.OcclusionStrength" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="7217.OcclusionStrength.range"/>
      </Property>
      <Property name="Opacity" id="7217.Opacity" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="7217.Opacity.range"/>
      </Property>
      <Property name="OpacityArray" id="7217.OpacityArray" number_of_elements="5">
        <Element index="0" value=""/>
        <Element index="1" value=""/>
        <Element index="2" value=""/>
        <Element index="3" value="0"/>
        <Element index="4" value="ids"/>
        <Domain name="array_list" id="7217.OpacityArray.array_list">
          <String text="ids"/>
        </Domain>
      </Property>
      <Property name="OpacityArrayComponent" id="7217.OpacityArrayComponent" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="comps" id="7217.OpacityArrayComponent.comps">
          <Entry value="0" text=""/>
        </Domain>
      </Property>
      <Property name="OpacityArrayName" id="7217.OpacityArrayName" number_of_elements="5">
        <Element index="0" value=""/>
        <Element index="1" value=""/>
        <Element index="2" value=""/>
        <Element index="3" value="0"/>
        <Element index="4" value="ids"/>
        <Domain name="array_list" id="7217.OpacityArrayName.array_list">
          <String text="ids"/>
          <String text="ids"/>
          <String text="mixing_len"/>
          <String text="mu_t"/>
          <String text="object_id"/>
          <String text="power_density"/>
          <String text="pressure"/>
          <String text="vel"/>
          <String text="Information Records"/>
          <String text="QA Records"/>
          <String text="max_vel"/>
          <String text="min_vel_z"/>
        </Domain>
      </Property>
      <Property name="OpacityByArray" id="7217.OpacityByArray" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7217.OpacityByArray.bool"/>
      </Property>
      <Property name="OpacityComponent" id="7217.OpacityComponent" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="comps" id="7217.OpacityComponent.comps">
          <Entry value="0" text=""/>
        </Domain>
      </Property>
      <Property name="OpacityTransferFunction" id="7217.OpacityTransferFunction" number_of_elements="1">
        <Proxy value="7142"/>
        <Domain name="proxy_list" id="7217.OpacityTransferFunction.proxy_list">
          <Proxy value="7142"/>
        </Domain>
      </Property>
      <Property name="Orient" id="7217.Orient" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7217.Orient.bool"/>
      </Property>
      <Property name="Orientation" id="7217.Orientation" number_of_elements="3">
        <Element index="0" value="0"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0"/>
        <Domain name="range" id="7217.Orientation.range"/>
      </Property>
      <Property name="OrientationMode" id="7217.OrientationMode" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="7217.OrientationMode.enum">
          <Entry value="0" text="Direction"/>
          <Entry value="1" text="Rotation"/>
          <Entry value="2" text="Quaternion"/>
        </Domain>
      </Property>
      <Property name="Origin" id="7217.Origin" number_of_elements="3">
        <Element index="0" value="0"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0"/>
        <Domain name="range" id="7217.Origin.range"/>
      </Property>
      <Property name="Pickable" id="7217.Pickable" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="7217.Pickable.bool"/>
      </Property>
      <Property name="PointSize" id="7217.PointSize" number_of_elements="1">
        <Element index="0" value="2"/>
        <Domain name="range" id="7217.PointSize.range"/>
      </Property>
      <Property name="RenderLinesAsTubes" id="7217.RenderLinesAsTubes" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7217.RenderLinesAsTubes.bool"/>
      </Property>
      <Property name="RenderPointsAsSpheres" id="7217.RenderPointsAsSpheres" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7217.RenderPointsAsSpheres.bool"/>
      </Property>
      <Property name="RepeatTextures" id="7217.RepeatTextures" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="7217.RepeatTextures.bool"/>
      </Property>
      <Property name="Roughness" id="7217.Roughness" number_of_elements="1">
        <Element index="0" value="0.3"/>
        <Domain name="range" id="7217.Roughness.range"/>
      </Property>
      <Property name="SamplingDimensions" id="7217.SamplingDimensions" number_of_elements="3">
        <Element index="0" value="128"/>
        <Element index="1" value="128"/>
        <Element index="2" value="128"/>
        <Domain name="range" id="7217.SamplingDimensions.range"/>
      </Property>
      <Property name="ScalarOpacityFunction" id="7217.ScalarOpacityFunction" number_of_elements="1">
        <Proxy value="6951"/>
        <Domain name="groups" id="7217.ScalarOpacityFunction.groups"/>
      </Property>
      <Property name="ScalarOpacityUnitDistance" id="7217.ScalarOpacityUnitDistance" number_of_elements="1">
        <Element index="0" value="0.20305243303660872"/>
        <Domain name="bounds" id="7217.ScalarOpacityUnitDistance.bounds"/>
      </Property>
      <Property name="Scale" id="7217.Scale" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="7217.Scale.range"/>
      </Property>
      <Property name="ScaleArrayComponent" id="7217.ScaleArrayComponent" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="comps" id="7217.ScaleArrayComponent.comps">
          <Entry value="0" text=""/>
        </Domain>
      </Property>
      <Property name="ScaleByArray" id="7217.ScaleByArray" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7217.ScaleByArray.bool"/>
      </Property>
      <Property name="ScaleFactor" id="7217.ScaleFactor" number_of_elements="1">
        <Element index="0" value="0.43147975082902096"/>
        <Domain name="bounds" id="7217.ScaleFactor.bounds"/>
        <Domain name="scalar_range" id="7217.ScaleFactor.scalar_range"/>
        <Domain name="vector_range" id="7217.ScaleFactor.vector_range"/>
      </Property>
      <Property name="ScaleMode" id="7217.ScaleMode" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="7217.ScaleMode.enum">
          <Entry value="0" text="No Data Scaling Off"/>
          <Entry value="1" text="Magnitude"/>
          <Entry value="2" text="Vector Components"/>
        </Domain>
      </Property>
      <Property name="ScaleTransferFunction" id="7217.ScaleTransferFunction" number_of_elements="1">
        <Proxy value="7143"/>
        <Domain name="proxy_list" id="7217.ScaleTransferFunction.proxy_list">
          <Proxy value="7143"/>
        </Domain>
      </Property>
      <Property name="Scaling" id="7217.Scaling" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7217.Scaling.bool"/>
      </Property>
      <Property name="SeamlessU" id="7217.SeamlessU" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7217.SeamlessU.bool"/>
      </Property>
      <Property name="SeamlessV" id="7217.SeamlessV" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7217.SeamlessV.bool"/>
      </Property>
      <Property name="SelectInputVectors" id="7217.SelectInputVectors" number_of_elements="5">
        <Element index="0" value=""/>
        <Element index="1" value=""/>
        <Element index="2" value=""/>
        <Element index="3" value=""/>
        <Element index="4" value=""/>
        <Domain name="array_list" id="7217.SelectInputVectors.array_list"/>
      </Property>
      <Property name="SelectMapper" id="7217.SelectMapper" number_of_elements="1">
        <Element index="0" value="Projected tetra"/>
        <Domain name="list" id="7217.SelectMapper.list">
          <String text="Projected tetra"/>
          <String text="Z sweep"/>
          <String text="Bunyk ray cast"/>
          <String text="Resample To Image"/>
        </Domain>
      </Property>
      <Property name="SelectMaskArray" id="7217.SelectMaskArray" number_of_elements="1">
        <Element index="0" value=""/>
      </Property>
      <Property name="SelectNormalArray" id="7217.SelectNormalArray" number_of_elements="1">
        <Element index="0" value="None"/>
        <Domain name="array_list" id="7217.SelectNormalArray.array_list">
          <String text="None"/>
        </Domain>
      </Property>
      <Property name="SelectOrientationVectors" id="7217.SelectOrientationVectors" number_of_elements="1">
        <Element index="0" value="None"/>
        <Domain name="array_list" id="7217.SelectOrientationVectors.array_list">
          <String text="None"/>
          <String text="vel"/>
        </Domain>
      </Property>
      <Property name="SelectScaleArray" id="7217.SelectScaleArray" number_of_elements="1">
        <Element index="0" value="None"/>
        <Domain name="array_list" id="7217.SelectScaleArray.array_list">
          <String text="None"/>
          <String text="ids"/>
          <String text="ids"/>
          <String text="mixing_len"/>
          <String text="mu_t"/>
          <String text="object_id"/>
          <String text="power_density"/>
          <String text="pressure"/>
          <String text="vel"/>
        </Domain>
      </Property>
      <Property name="SelectTCoordArray" id="7217.SelectTCoordArray" number_of_elements="1">
        <Element index="0" value="None"/>
        <Domain name="array_list" id="7217.SelectTCoordArray.array_list">
          <String text="None"/>
        </Domain>
      </Property>
      <Property name="SelectTangentArray" id="7217.SelectTangentArray" number_of_elements="1">
        <Element index="0" value="None"/>
        <Domain name="array_list" id="7217.SelectTangentArray.array_list">
          <String text="None"/>
        </Domain>
      </Property>
      <Property name="SelectedBlockSelectors" id="7217.SelectedBlockSelectors" number_of_elements="1">
        <Element index="0" value=""/>
        <Domain name="data_assembly" id="7217.SelectedBlockSelectors.data_assembly"/>
      </Property>
      <Property name="SelectionCellLabelBold" id="7217.SelectionCellLabelBold" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7217.SelectionCellLabelBold.bool"/>
      </Property>
      <Property name="SelectionCellLabelColor" id="7217.SelectionCellLabelColor" number_of_elements="3">
        <Element index="0" value="0"/>
        <Element index="1" value="1"/>
        <Element index="2" value="0"/>
        <Domain name="range" id="7217.SelectionCellLabelColor.range"/>
      </Property>
      <Property name="SelectionCellLabelFontFamily" id="7217.SelectionCellLabelFontFamily" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="7217.SelectionCellLabelFontFamily.enum">
          <Entry value="0" text="Arial"/>
          <Entry value="1" text="Courier"/>
          <Entry value="2" text="Times"/>
          <Entry value="4" text="File"/>
        </Domain>
      </Property>
      <Property name="SelectionCellLabelFontFile" id="7217.SelectionCellLabelFontFile" number_of_elements="1">
        <Element index="0" value=""/>
      </Property>
      <Property name="SelectionCellLabelFontSize" id="7217.SelectionCellLabelFontSize" number_of_elements="1">
        <Element index="0" value="18"/>
        <Domain name="range" id="7217.SelectionCellLabelFontSize.range"/>
      </Property>
      <Property name="SelectionCellLabelFormat" id="7217.SelectionCellLabelFormat" number_of_elements="1">
        <Element index="0" value=""/>
      </Property>
      <Property name="SelectionCellLabelItalic" id="7217.SelectionCellLabelItalic" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7217.SelectionCellLabelItalic.bool"/>
      </Property>
      <Property name="SelectionCellLabelJustification" id="7217.SelectionCellLabelJustification" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="7217.SelectionCellLabelJustification.enum">
          <Entry value="0" text="Left"/>
          <Entry value="1" text="Center"/>
          <Entry value="2" text="Right"/>
        </Domain>
      </Property>
      <Property name="SelectionCellLabelOpacity" id="7217.SelectionCellLabelOpacity" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="7217.SelectionCellLabelOpacity.range"/>
      </Property>
      <Property name="SelectionCellLabelShadow" id="7217.SelectionCellLabelShadow" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7217.SelectionCellLabelShadow.bool"/>
      </Property>
      <Property name="SelectionCellLabelVisibility" id="7217.SelectionCellLabelVisibility" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7217.SelectionCellLabelVisibility.bool"/>
      </Property>
      <Property name="SelectionColor" id="7217.SelectionColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="0"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="7217.SelectionColor.range"/>
      </Property>
      <Property name="SelectionLineWidth" id="7217.SelectionLineWidth" number_of_elements="1">
        <Element index="0" value="2"/>
        <Domain name="range" id="7217.SelectionLineWidth.range"/>
      </Property>
      <Property name="SelectionMaximumNumberOfLabels" id="7217.SelectionMaximumNumberOfLabels" number_of_elements="1">
        <Element index="0" value="100"/>
        <Domain name="range" id="7217.SelectionMaximumNumberOfLabels.range"/>
      </Property>
      <Property name="SelectionOpacity" id="7217.SelectionOpacity" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="7217.SelectionOpacity.range"/>
      </Property>
      <Property name="SelectionPointLabelBold" id="7217.SelectionPointLabelBold" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7217.SelectionPointLabelBold.bool"/>
      </Property>
      <Property name="SelectionPointLabelColor" id="7217.SelectionPointLabelColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="0"/>
        <Domain name="range" id="7217.SelectionPointLabelColor.range"/>
      </Property>
      <Property name="SelectionPointLabelFontFamily" id="7217.SelectionPointLabelFontFamily" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="7217.SelectionPointLabelFontFamily.enum">
          <Entry value="0" text="Arial"/>
          <Entry value="1" text="Courier"/>
          <Entry value="2" text="Times"/>
          <Entry value="4" text="File"/>
        </Domain>
      </Property>
      <Property name="SelectionPointLabelFontFile" id="7217.SelectionPointLabelFontFile" number_of_elements="1">
        <Element index="0" value=""/>
      </Property>
      <Property name="SelectionPointLabelFontSize" id="7217.SelectionPointLabelFontSize" number_of_elements="1">
        <Element index="0" value="18"/>
        <Domain name="range" id="7217.SelectionPointLabelFontSize.range"/>
      </Property>
      <Property name="SelectionPointLabelFormat" id="7217.SelectionPointLabelFormat" number_of_elements="1">
        <Element index="0" value=""/>
      </Property>
      <Property name="SelectionPointLabelItalic" id="7217.SelectionPointLabelItalic" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7217.SelectionPointLabelItalic.bool"/>
      </Property>
      <Property name="SelectionPointLabelJustification" id="7217.SelectionPointLabelJustification" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="7217.SelectionPointLabelJustification.enum">
          <Entry value="0" text="Left"/>
          <Entry value="1" text="Center"/>
          <Entry value="2" text="Right"/>
        </Domain>
      </Property>
      <Property name="SelectionPointLabelOpacity" id="7217.SelectionPointLabelOpacity" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="7217.SelectionPointLabelOpacity.range"/>
      </Property>
      <Property name="SelectionPointLabelShadow" id="7217.SelectionPointLabelShadow" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7217.SelectionPointLabelShadow.bool"/>
      </Property>
      <Property name="SelectionPointLabelVisibility" id="7217.SelectionPointLabelVisibility" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7217.SelectionPointLabelVisibility.bool"/>
      </Property>
      <Property name="SelectionPointSize" id="7217.SelectionPointSize" number_of_elements="1">
        <Element index="0" value="5"/>
        <Domain name="range" id="7217.SelectionPointSize.range"/>
      </Property>
      <Property name="SelectionRepresentation" id="7217.SelectionRepresentation" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="enum" id="7217.SelectionRepresentation.enum">
          <Entry value="0" text="Points"/>
          <Entry value="1" text="Wireframe"/>
          <Entry value="2" text="Surface"/>
        </Domain>
      </Property>
      <Property name="SelectionUseOutline" id="7217.SelectionUseOutline" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7217.SelectionUseOutline.bool"/>
      </Property>
      <Property name="SetScaleArray" id="7217.SetScaleArray" number_of_elements="5">
        <Element index="0" value=""/>
        <Element index="1" value=""/>
        <Element index="2" value=""/>
        <Element index="3" value="0"/>
        <Element index="4" value="ids"/>
        <Domain name="array_list" id="7217.SetScaleArray.array_list">
          <String text="ids"/>
        </Domain>
      </Property>
      <Property name="ShaderPreset" id="7217.ShaderPreset" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="enum" id="7217.ShaderPreset.enum">
          <Entry value="0" text="Gaussian Blur"/>
          <Entry value="1" text="Sphere"/>
          <Entry value="2" text="Black-edged circle"/>
          <Entry value="3" text="Plain circle"/>
          <Entry value="4" text="Triangle"/>
          <Entry value="5" text="Square Outline"/>
          <Entry value="6" text="Custom"/>
        </Domain>
      </Property>
      <Property name="ShaderReplacements" id="7217.ShaderReplacements" number_of_elements="1">
        <Element index="0" value=""/>
      </Property>
      <Property name="ShowTexturesOnBackface" id="7217.ShowTexturesOnBackface" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="7217.ShowTexturesOnBackface.bool"/>
      </Property>
      <Property name="Specular" id="7217.Specular" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="7217.Specular.range"/>
      </Property>
      <Property name="SpecularColor" id="7217.SpecularColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="7217.SpecularColor.range"/>
      </Property>
      <Property name="SpecularPower" id="7217.SpecularPower" number_of_elements="1">
        <Element index="0" value="100"/>
        <Domain name="range" id="7217.SpecularPower.range"/>
      </Property>
      <Property name="Splitting" id="7217.Splitting" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="7217.Splitting.bool"/>
      </Property>
      <Property name="StaticMode" id="7217.StaticMode" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7217.StaticMode.bool"/>
      </Property>
      <Property name="StepSize" id="7217.StepSize" number_of_elements="1">
        <Element index="0" value="0.25"/>
        <Domain name="range" id="7217.StepSize.range"/>
      </Property>
      <Property name="SuppressLOD" id="7217.SuppressLOD" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7217.SuppressLOD.bool"/>
      </Property>
      <Property name="Texture" id="7217.Texture">
        <Domain name="groups" id="7217.Texture.groups"/>
      </Property>
      <Property name="TextureTransform" id="7217.TextureTransform" number_of_elements="1">
        <Proxy value="7189"/>
        <Domain name="groups" id="7217.TextureTransform.groups"/>
        <Domain name="proxy_list" id="7217.TextureTransform.proxy_list">
          <Proxy value="7189"/>
        </Domain>
      </Property>
      <Property name="Translation" id="7217.Translation" number_of_elements="3">
        <Element index="0" value="0"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0"/>
        <Domain name="range" id="7217.Translation.range"/>
      </Property>
      <Property name="Triangulate" id="7217.Triangulate" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7217.Triangulate.bool"/>
      </Property>
      <Property name="UseCompositeGlyphTable" id="7217.UseCompositeGlyphTable" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7217.UseCompositeGlyphTable.bool"/>
      </Property>
      <Property name="UseDataPartitions" id="7217.UseDataPartitions" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7217.UseDataPartitions.bool"/>
      </Property>
      <Property name="UseFloatingPointFrameBuffer" id="7217.UseFloatingPointFrameBuffer" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="7217.UseFloatingPointFrameBuffer.bool"/>
      </Property>
      <Property name="UseGlyphCullingAndLOD" id="7217.UseGlyphCullingAndLOD" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7217.UseGlyphCullingAndLOD.bool"/>
      </Property>
      <Property name="UseGlyphTable" id="7217.UseGlyphTable" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7217.UseGlyphTable.bool"/>
      </Property>
      <Property name="UseLICForLOD" id="7217.UseLICForLOD" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7217.UseLICForLOD.bool"/>
      </Property>
      <Property name="UseMipmapTextures" id="7217.UseMipmapTextures" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7217.UseMipmapTextures.bool"/>
      </Property>
      <Property name="UseNanColorForMissingArrays" id="7217.UseNanColorForMissingArrays" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7217.UseNanColorForMissingArrays.bool"/>
      </Property>
      <Property name="UseScaleFunction" id="7217.UseScaleFunction" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="7217.UseScaleFunction.bool"/>
      </Property>
      <Property name="UseSeparateColorMap" id="7217.UseSeparateColorMap" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7217.UseSeparateColorMap.bool"/>
      </Property>
      <Property name="UseSeparateOpacityArray" id="7217.UseSeparateOpacityArray" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7217.UseSeparateOpacityArray.bool"/>
      </Property>
      <Property name="UseShaderReplacements" id="7217.UseShaderReplacements" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="7217.UseShaderReplacements.bool"/>
      </Property>
      <Property name="UserTransform" id="7217.UserTransform" number_of_elements="16">
        <Element index="0" value="1"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0"/>
        <Element index="3" value="0"/>
        <Element index="4" value="0"/>
        <Element index="5" value="1"/>
        <Element index="6" value="0"/>
        <Element index="7" value="0"/>
        <Element index="8" value="0"/>
        <Element index="9" value="0"/>
        <Element index="10" value="1"/>
        <Element index="11" value="0"/>
        <Element index="12" value="0"/>
        <Element index="13" value="0"/>
        <Element index="14" value="0"/>
        <Element index="15" value="1"/>
      </Property>
      <Property name="WriteLog" id="7217.WriteLog" number_of_elements="1">
        <Element index="0" value=""/>
      </Property>
    </Proxy>
    <Proxy group="representations" type="ScalarBarWidgetRepresentation" id="6960" servers="21">
      <Property name="Enabled" id="6960.Enabled" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6960.Enabled.bool"/>
      </Property>
      <Property name="LockPosition" id="6960.LockPosition" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6960.LockPosition.bool"/>
      </Property>
      <Property name="StickyVisible" id="6960.StickyVisible" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6960.StickyVisible.bool"/>
      </Property>
      <Property name="UseNonCompositedRenderer" id="6960.UseNonCompositedRenderer" number_of_elements="1">
        <Element index="0" value="1"/>
      </Property>
      <Property name="AddRangeAnnotations" id="6960.AddRangeAnnotations" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6960.AddRangeAnnotations.bool"/>
      </Property>
      <Property name="AddRangeLabels" id="6960.AddRangeLabels" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6960.AddRangeLabels.bool"/>
      </Property>
      <Property name="AutoOrient" id="6960.AutoOrient" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6960.AutoOrient.bool"/>
      </Property>
      <Property name="AutoOrientInfo" id="6960.AutoOrientInfo" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6960.AutoOrientInfo.bool"/>
      </Property>
      <Property name="AutomaticAnnotations" id="6960.AutomaticAnnotations" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6960.AutomaticAnnotations.bool"/>
      </Property>
      <Property name="AutomaticLabelFormat" id="6960.AutomaticLabelFormat" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6960.AutomaticLabelFormat.bool"/>
      </Property>
      <Property name="BackgroundColor" id="6960.BackgroundColor" number_of_elements="4">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Element index="3" value="0.5"/>
        <Domain name="range" id="6960.BackgroundColor.range"/>
      </Property>
      <Property name="BackgroundPadding" id="6960.BackgroundPadding" number_of_elements="1">
        <Element index="0" value="2"/>
      </Property>
      <Property name="ComponentTitle" id="6960.ComponentTitle" number_of_elements="1">
        <Element index="0" value="Magnitude"/>
      </Property>
      <Property name="CustomLabels" id="6960.CustomLabels"/>
      <Property name="DataRangeLabelFormat" id="6960.DataRangeLabelFormat" number_of_elements="1">
        <Element index="0" value="{:&#x3c;#6.1e}"/>
      </Property>
      <Property name="DataRangeMax" id="6960.DataRangeMax" number_of_elements="1">
        <Element index="0" value="6.657929770334448e+45"/>
      </Property>
      <Property name="DataRangeMin" id="6960.DataRangeMin" number_of_elements="1">
        <Element index="0" value="1.3224986173020592e+32"/>
      </Property>
      <Property name="DrawAnnotations" id="6960.DrawAnnotations" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6960.DrawAnnotations.bool"/>
      </Property>
      <Property name="DrawBackground" id="6960.DrawBackground" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6960.DrawBackground.bool"/>
      </Property>
      <Property name="DrawDataRange" id="6960.DrawDataRange" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6960.DrawDataRange.bool"/>
      </Property>
      <Property name="DrawNanAnnotation" id="6960.DrawNanAnnotation" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6960.DrawNanAnnotation.bool"/>
      </Property>
      <Property name="DrawScalarBarOutline" id="6960.DrawScalarBarOutline" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6960.DrawScalarBarOutline.bool"/>
      </Property>
      <Property name="DrawTickLabels" id="6960.DrawTickLabels" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6960.DrawTickLabels.bool"/>
      </Property>
      <Property name="DrawTickMarks" id="6960.DrawTickMarks" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6960.DrawTickMarks.bool"/>
      </Property>
      <Property name="EstimatedNumberOfAnnotations" id="6960.EstimatedNumberOfAnnotations" number_of_elements="1">
        <Element index="0" value="0"/>
      </Property>
      <Property name="HorizontalTitle" id="6960.HorizontalTitle" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6960.HorizontalTitle.bool"/>
      </Property>
      <Property name="LabelBold" id="6960.LabelBold" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6960.LabelBold.bool"/>
      </Property>
      <Property name="LabelColor" id="6960.LabelColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="6960.LabelColor.range"/>
      </Property>
      <Property name="LabelFontFamily" id="6960.LabelFontFamily" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="6960.LabelFontFamily.enum">
          <Entry value="0" text="Arial"/>
          <Entry value="1" text="Courier"/>
          <Entry value="2" text="Times"/>
          <Entry value="4" text="File"/>
        </Domain>
      </Property>
      <Property name="LabelFontFile" id="6960.LabelFontFile" number_of_elements="1">
        <Element index="0" value=""/>
      </Property>
      <Property name="LabelFontSize" id="6960.LabelFontSize" number_of_elements="1">
        <Element index="0" value="16"/>
        <Domain name="range" id="6960.LabelFontSize.range"/>
      </Property>
      <Property name="LabelFormat" id="6960.LabelFormat" number_of_elements="1">
        <Element index="0" value="{:&#x3c;#6.3g}"/>
      </Property>
      <Property name="LabelItalic" id="6960.LabelItalic" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6960.LabelItalic.bool"/>
      </Property>
      <Property name="LabelOpacity" id="6960.LabelOpacity" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="6960.LabelOpacity.range"/>
      </Property>
      <Property name="LabelShadow" id="6960.LabelShadow" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6960.LabelShadow.bool"/>
      </Property>
      <Property name="LookupTable" id="6960.LookupTable" number_of_elements="1">
        <Proxy value="6953"/>
        <Domain name="groups" id="6960.LookupTable.groups"/>
      </Property>
      <Property name="NanAnnotation" id="6960.NanAnnotation" number_of_elements="1">
        <Element index="0" value="NaN"/>
      </Property>
      <Property name="Orientation" id="6960.Orientation" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="enum" id="6960.Orientation.enum">
          <Entry value="0" text="Horizontal"/>
          <Entry value="1" text="Vertical"/>
        </Domain>
      </Property>
      <Property name="OrientationInfo" id="6960.OrientationInfo" number_of_elements="1">
        <Element index="0" value="1"/>
      </Property>
      <Property name="Position" id="6960.Position" number_of_elements="2">
        <Element index="0" value="0.89"/>
        <Element index="1" value="0.02"/>
        <Domain name="range" id="6960.Position.range"/>
      </Property>
      <Property name="PositionInfo" id="6960.PositionInfo" number_of_elements="2">
        <Element index="0" value="0.89"/>
        <Element index="1" value="0.02"/>
      </Property>
      <Property name="RangeLabelFormat" id="6960.RangeLabelFormat" number_of_elements="1">
        <Element index="0" value="{:&#x3c;#6.1e}"/>
      </Property>
      <Property name="Repositionable" id="6960.Repositionable" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6960.Repositionable.bool"/>
      </Property>
      <Property name="Resizable" id="6960.Resizable" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6960.Resizable.bool"/>
      </Property>
      <Property name="ReverseLegend" id="6960.ReverseLegend" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6960.ReverseLegend.bool"/>
      </Property>
      <Property name="ScalarBarLength" id="6960.ScalarBarLength" number_of_elements="1">
        <Element index="0" value="0.33"/>
      </Property>
      <Property name="ScalarBarOutlineColor" id="6960.ScalarBarOutlineColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
      </Property>
      <Property name="ScalarBarOutlineThickness" id="6960.ScalarBarOutlineThickness" number_of_elements="1">
        <Element index="0" value="1"/>
      </Property>
      <Property name="ScalarBarThickness" id="6960.ScalarBarThickness" number_of_elements="1">
        <Element index="0" value="16"/>
      </Property>
      <Property name="Selectable" id="6960.Selectable" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6960.Selectable.bool"/>
      </Property>
      <Property name="TextPosition" id="6960.TextPosition" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="enum" id="6960.TextPosition.enum">
          <Entry value="1" text="Ticks right/top, annotations left/bottom"/>
          <Entry value="0" text="Ticks left/bottom, annotations right/top"/>
        </Domain>
      </Property>
      <Property name="Title" id="6960.Title" number_of_elements="1">
        <Element index="0" value="vel"/>
      </Property>
      <Property name="TitleBold" id="6960.TitleBold" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6960.TitleBold.bool"/>
      </Property>
      <Property name="TitleColor" id="6960.TitleColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="6960.TitleColor.range"/>
      </Property>
      <Property name="TitleFontFamily" id="6960.TitleFontFamily" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="6960.TitleFontFamily.enum">
          <Entry value="0" text="Arial"/>
          <Entry value="1" text="Courier"/>
          <Entry value="2" text="Times"/>
          <Entry value="4" text="File"/>
        </Domain>
      </Property>
      <Property name="TitleFontFile" id="6960.TitleFontFile" number_of_elements="1">
        <Element index="0" value=""/>
      </Property>
      <Property name="TitleFontSize" id="6960.TitleFontSize" number_of_elements="1">
        <Element index="0" value="16"/>
        <Domain name="range" id="6960.TitleFontSize.range"/>
      </Property>
      <Property name="TitleItalic" id="6960.TitleItalic" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6960.TitleItalic.bool"/>
      </Property>
      <Property name="TitleJustification" id="6960.TitleJustification" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="enum" id="6960.TitleJustification.enum">
          <Entry value="0" text="Left"/>
          <Entry value="1" text="Centered"/>
          <Entry value="2" text="Right"/>
        </Domain>
      </Property>
      <Property name="TitleOpacity" id="6960.TitleOpacity" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="6960.TitleOpacity.range"/>
      </Property>
      <Property name="TitleShadow" id="6960.TitleShadow" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6960.TitleShadow.bool"/>
      </Property>
      <Property name="UseCustomLabels" id="6960.UseCustomLabels" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6960.UseCustomLabels.bool"/>
      </Property>
      <Property name="Visibility" id="6960.Visibility" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6960.Visibility.bool"/>
      </Property>
      <Property name="WindowLocation" id="6960.WindowLocation" number_of_elements="1">
        <Element index="0" value="2"/>
        <Domain name="enum" id="6960.WindowLocation.enum">
          <Entry value="0" text="Any Location"/>
          <Entry value="1" text="Lower Left Corner"/>
          <Entry value="2" text="Lower Right Corner"/>
          <Entry value="3" text="Lower Center"/>
          <Entry value="4" text="Upper Left Corner"/>
          <Entry value="5" text="Upper Right Corner"/>
          <Entry value="6" text="Upper Center"/>
        </Domain>
      </Property>
    </Proxy>
    <Proxy group="settings" type="ColorPalette" id="267" servers="21">
      <Property name="BackgroundColor" id="267.BackgroundColor" number_of_elements="3">
        <Element index="0" value="0.384313725"/>
        <Element index="1" value="0.364705882"/>
        <Element index="2" value="0.352941176"/>
        <Domain name="range" id="267.BackgroundColor.range"/>
      </Property>
      <Property name="BackgroundColor2" id="267.BackgroundColor2" number_of_elements="3">
        <Element index="0" value="0"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0.16"/>
        <Domain name="range" id="267.BackgroundColor2.range"/>
      </Property>
      <Property name="BackgroundColorMode" id="267.BackgroundColorMode" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="267.BackgroundColorMode.enum">
          <Entry value="0" text="Single Color"/>
          <Entry value="1" text="Gradient"/>
        </Domain>
      </Property>
      <Property name="BorderColor" id="267.BorderColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="0"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="267.BorderColor.range"/>
      </Property>
      <Property name="EdgeColor" id="267.EdgeColor" number_of_elements="3">
        <Element index="0" value="0"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0.5"/>
        <Domain name="range" id="267.EdgeColor.range"/>
      </Property>
      <Property name="ForegroundColor" id="267.ForegroundColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="267.ForegroundColor.range"/>
      </Property>
      <Property name="InteractiveSelectionColor" id="267.InteractiveSelectionColor" number_of_elements="3">
        <Element index="0" value="0.5"/>
        <Element index="1" value="0"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="267.InteractiveSelectionColor.range"/>
      </Property>
      <Property name="InteractiveWidgetColor" id="267.InteractiveWidgetColor" number_of_elements="3">
        <Element index="0" value="0"/>
        <Element index="1" value="1"/>
        <Element index="2" value="0"/>
        <Domain name="range" id="267.InteractiveWidgetColor.range"/>
      </Property>
      <Property name="LoadPalette" id="267.LoadPalette"/>
      <Property name="SelectionColor" id="267.SelectionColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="0"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="267.SelectionColor.range"/>
      </Property>
      <Property name="SurfaceColor" id="267.SurfaceColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="267.SurfaceColor.range"/>
      </Property>
      <Property name="TextAnnotationColor" id="267.TextAnnotationColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
        <Domain name="range" id="267.TextAnnotationColor.range"/>
      </Property>
      <Property name="WidgetColor" id="267.WidgetColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0"/>
        <Domain name="range" id="267.WidgetColor.range"/>
      </Property>
    </Proxy>
    <Proxy group="filters" type="Threshold" id="6975" servers="1">
      <Property name="AllScalars" id="6975.AllScalars" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6975.AllScalars.bool"/>
      </Property>
      <Property name="ComponentMode" id="6975.ComponentMode" number_of_elements="1">
        <Element index="0" value="2"/>
        <Domain name="enum" id="6975.ComponentMode.enum">
          <Entry value="0" text="Selected"/>
          <Entry value="1" text="All"/>
          <Entry value="2" text="Any"/>
        </Domain>
      </Property>
      <Property name="Input" id="6975.Input" number_of_elements="1">
        <Proxy value="6577" output_port="0"/>
        <Domain name="groups" id="6975.Input.groups"/>
        <Domain name="input_array" id="6975.Input.input_array"/>
        <Domain name="input_type" id="6975.Input.input_type"/>
      </Property>
      <Property name="Invert" id="6975.Invert" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6975.Invert.bool"/>
      </Property>
      <Property name="LowerThreshold" id="6975.LowerThreshold" number_of_elements="1">
        <Element index="0" value="10000000000"/>
        <Domain name="range" id="6975.LowerThreshold.range"/>
      </Property>
      <Property name="MemoryStrategy" id="6975.MemoryStrategy" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="6975.MemoryStrategy.enum">
          <Entry value="0" text="Mask Input"/>
          <Entry value="1" text="Regenerate Trees And Index Fields"/>
          <Entry value="2" text="New HyperTreeGrid"/>
        </Domain>
      </Property>
      <Property name="SelectInputScalars" id="6975.SelectInputScalars" number_of_elements="5">
        <Element index="0" value=""/>
        <Element index="1" value=""/>
        <Element index="2" value=""/>
        <Element index="3" value="1"/>
        <Element index="4" value="vel"/>
        <Domain name="array_list" id="6975.SelectInputScalars.array_list">
          <String text="ids"/>
          <String text="ids"/>
          <String text="mixing_len"/>
          <String text="mu_t"/>
          <String text="object_id"/>
          <String text="power_density"/>
          <String text="pressure"/>
          <String text="vel"/>
        </Domain>
      </Property>
      <Property name="SelectedComponent" id="6975.SelectedComponent" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="comps" id="6975.SelectedComponent.comps">
          <Entry value="0" text="X"/>
          <Entry value="1" text="Y"/>
          <Entry value="2" text="Z"/>
          <Entry value="3" text="Magnitude"/>
        </Domain>
      </Property>
      <Property name="ThresholdMethod" id="6975.ThresholdMethod" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="6975.ThresholdMethod.enum">
          <Entry value="0" text="Between"/>
          <Entry value="1" text="Below Lower Threshold"/>
          <Entry value="2" text="Above Upper Threshold"/>
        </Domain>
      </Property>
      <Property name="UpperThreshold" id="6975.UpperThreshold" number_of_elements="1">
        <Element index="0" value="1e+50"/>
        <Domain name="range" id="6975.UpperThreshold.range"/>
      </Property>
      <Property name="UseContinuousCellRange" id="6975.UseContinuousCellRange" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6975.UseContinuousCellRange.bool"/>
      </Property>
    </Proxy>
    <Proxy group="sources" type="IOSSReader" id="6577" servers="1">
      <Property name="ApplyDisplacements" id="6577.ApplyDisplacements" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6577.ApplyDisplacements.bool"/>
      </Property>
      <Property name="AssemblySelectors" id="6577.AssemblySelectors">
        <Domain name="data_assembly" id="6577.AssemblySelectors.data_assembly"/>
      </Property>
      <Property name="AssemblyTag" id="6577.AssemblyTag" number_of_elements="1">
        <Element index="0" value="0"/>
      </Property>
      <Property name="Caching" id="6577.Caching" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6577.Caching.bool"/>
      </Property>
      <Property name="CatalystConduitChannelName" id="6577.CatalystConduitChannelName" number_of_elements="1">
        <Element index="0" value="input"/>
      </Property>
      <Property name="DisplacementMagnitude" id="6577.DisplacementMagnitude" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="6577.DisplacementMagnitude.range"/>
      </Property>
      <Property name="EdgeBlockFieldInfo" id="6577.EdgeBlockFieldInfo"/>
      <Property name="EdgeBlockFields" id="6577.EdgeBlockFields">
        <Domain name="array_list" id="6577.EdgeBlockFields.array_list"/>
      </Property>
      <Property name="EdgeBlockInfo" id="6577.EdgeBlockInfo"/>
      <Property name="EdgeBlocks" id="6577.EdgeBlocks">
        <Domain name="array_list" id="6577.EdgeBlocks.array_list"/>
      </Property>
      <Property name="EdgeBlocksIdInfo" id="6577.EdgeBlocksIdInfo"/>
      <Property name="EdgeSetFieldInfo" id="6577.EdgeSetFieldInfo"/>
      <Property name="EdgeSetFields" id="6577.EdgeSetFields">
        <Domain name="array_list" id="6577.EdgeSetFields.array_list"/>
      </Property>
      <Property name="EdgeSetInfo" id="6577.EdgeSetInfo"/>
      <Property name="EdgeSets" id="6577.EdgeSets">
        <Domain name="array_list" id="6577.EdgeSets.array_list"/>
      </Property>
      <Property name="EdgeSetsIdInfo" id="6577.EdgeSetsIdInfo"/>
      <Property name="ElementBlockFieldInfo" id="6577.ElementBlockFieldInfo" number_of_elements="10">
        <Element index="0" value="mixing_len"/>
        <Element index="1" value="1"/>
        <Element index="2" value="mu_t"/>
        <Element index="3" value="1"/>
        <Element index="4" value="power_density"/>
        <Element index="5" value="1"/>
        <Element index="6" value="pressure"/>
        <Element index="7" value="1"/>
        <Element index="8" value="vel"/>
        <Element index="9" value="1"/>
      </Property>
      <Property name="ElementBlockFields" id="6577.ElementBlockFields" number_of_elements="10">
        <Element index="0" value="mixing_len"/>
        <Element index="1" value="1"/>
        <Element index="2" value="mu_t"/>
        <Element index="3" value="1"/>
        <Element index="4" value="power_density"/>
        <Element index="5" value="1"/>
        <Element index="6" value="pressure"/>
        <Element index="7" value="1"/>
        <Element index="8" value="vel"/>
        <Element index="9" value="1"/>
        <Domain name="array_list" id="6577.ElementBlockFields.array_list">
          <String text="mixing_len"/>
          <String text="mu_t"/>
          <String text="power_density"/>
          <String text="pressure"/>
          <String text="vel"/>
        </Domain>
      </Property>
      <Property name="ElementBlockInfo" id="6577.ElementBlockInfo" number_of_elements="2">
        <Element index="0" value="block_1"/>
        <Element index="1" value="1"/>
      </Property>
      <Property name="ElementBlocks" id="6577.ElementBlocks" number_of_elements="2">
        <Element index="0" value="block_1"/>
        <Element index="1" value="1"/>
        <Domain name="array_list" id="6577.ElementBlocks.array_list">
          <String text="block_1"/>
        </Domain>
      </Property>
      <Property name="ElementBlocksIdInfo" id="6577.ElementBlocksIdInfo" number_of_elements="2">
        <Element index="0" value="block_1"/>
        <Element index="1" value="1"/>
      </Property>
      <Property name="ElementSetFieldInfo" id="6577.ElementSetFieldInfo"/>
      <Property name="ElementSetFields" id="6577.ElementSetFields">
        <Domain name="array_list" id="6577.ElementSetFields.array_list"/>
      </Property>
      <Property name="ElementSetInfo" id="6577.ElementSetInfo"/>
      <Property name="ElementSets" id="6577.ElementSets">
        <Domain name="array_list" id="6577.ElementSets.array_list"/>
      </Property>
      <Property name="ElementSetsIdInfo" id="6577.ElementSetsIdInfo"/>
      <Property name="FaceBlockFieldInfo" id="6577.FaceBlockFieldInfo"/>
      <Property name="FaceBlockFields" id="6577.FaceBlockFields">
        <Domain name="array_list" id="6577.FaceBlockFields.array_list"/>
      </Property>
      <Property name="FaceBlockInfo" id="6577.FaceBlockInfo"/>
      <Property name="FaceBlocks" id="6577.FaceBlocks">
        <Domain name="array_list" id="6577.FaceBlocks.array_list"/>
      </Property>
      <Property name="FaceBlocksIdInfo" id="6577.FaceBlocksIdInfo"/>
      <Property name="FaceSetFieldInfo" id="6577.FaceSetFieldInfo"/>
      <Property name="FaceSetFields" id="6577.FaceSetFields">
        <Domain name="array_list" id="6577.FaceSetFields.array_list"/>
      </Property>
      <Property name="FaceSetInfo" id="6577.FaceSetInfo"/>
      <Property name="FaceSets" id="6577.FaceSets">
        <Domain name="array_list" id="6577.FaceSets.array_list"/>
      </Property>
      <Property name="FaceSetsIdInfo" id="6577.FaceSetsIdInfo"/>
      <Property name="FieldSuffixSeparator" id="6577.FieldSuffixSeparator" number_of_elements="1">
        <Element index="0" value=""/>
      </Property>
      <Property name="FileName" id="6577.FileName" number_of_elements="1">
        <Element index="0" value="//wsl$/Ubuntu/home/bruce/MSR-project/MSFR/stage3_cardinal/th_phase1_from_th_exodus_out.e"/>
        <Domain name="files" id="6577.FileName.files"/>
      </Property>
      <Property name="FileRange" id="6577.FileRange" number_of_elements="2">
        <Element index="0" value="0"/>
        <Element index="1" value="-1"/>
      </Property>
      <Property name="FileStride" id="6577.FileStride" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="6577.FileStride.range"/>
      </Property>
      <Property name="GenerateFileId" id="6577.GenerateFileId" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6577.GenerateFileId.bool"/>
      </Property>
      <Property name="GlobalFieldInfo" id="6577.GlobalFieldInfo" number_of_elements="4">
        <Element index="0" value="max_vel"/>
        <Element index="1" value="1"/>
        <Element index="2" value="min_vel_z"/>
        <Element index="3" value="1"/>
      </Property>
      <Property name="GlobalFields" id="6577.GlobalFields" number_of_elements="4">
        <Element index="0" value="max_vel"/>
        <Element index="1" value="1"/>
        <Element index="2" value="min_vel_z"/>
        <Element index="3" value="1"/>
        <Domain name="array_list" id="6577.GlobalFields.array_list">
          <String text="max_vel"/>
          <String text="min_vel_z"/>
        </Domain>
      </Property>
      <Property name="GroupAlphabeticVectorFieldComponents" id="6577.GroupAlphabeticVectorFieldComponents" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6577.GroupAlphabeticVectorFieldComponents.bool"/>
      </Property>
      <Property name="GroupNumericVectorFieldComponents" id="6577.GroupNumericVectorFieldComponents" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6577.GroupNumericVectorFieldComponents.bool"/>
      </Property>
      <Property name="IncludeGhostData" id="6577.IncludeGhostData" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6577.IncludeGhostData.bool"/>
      </Property>
      <Property name="MergeExodusEntityBlocks" id="6577.MergeExodusEntityBlocks" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6577.MergeExodusEntityBlocks.bool"/>
      </Property>
      <Property name="NodeBlockFieldInfo" id="6577.NodeBlockFieldInfo"/>
      <Property name="NodeBlockFields" id="6577.NodeBlockFields">
        <Domain name="array_list" id="6577.NodeBlockFields.array_list"/>
      </Property>
      <Property name="NodeSetFieldInfo" id="6577.NodeSetFieldInfo"/>
      <Property name="NodeSetFields" id="6577.NodeSetFields">
        <Domain name="array_list" id="6577.NodeSetFields.array_list"/>
      </Property>
      <Property name="NodeSetInfo" id="6577.NodeSetInfo" number_of_elements="6">
        <Element index="0" value="nodelist_1"/>
        <Element index="1" value="0"/>
        <Element index="2" value="nodelist_2"/>
        <Element index="3" value="0"/>
        <Element index="4" value="nodelist_3"/>
        <Element index="5" value="0"/>
      </Property>
      <Property name="NodeSets" id="6577.NodeSets" number_of_elements="6">
        <Element index="0" value="nodelist_1"/>
        <Element index="1" value="0"/>
        <Element index="2" value="nodelist_2"/>
        <Element index="3" value="0"/>
        <Element index="4" value="nodelist_3"/>
        <Element index="5" value="0"/>
        <Domain name="array_list" id="6577.NodeSets.array_list">
          <String text="nodelist_1"/>
          <String text="nodelist_2"/>
          <String text="nodelist_3"/>
        </Domain>
      </Property>
      <Property name="NodeSetsIdInfo" id="6577.NodeSetsIdInfo" number_of_elements="6">
        <Element index="0" value="nodelist_1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="nodelist_2"/>
        <Element index="3" value="2"/>
        <Element index="4" value="nodelist_3"/>
        <Element index="5" value="3"/>
      </Property>
      <Property name="ReadAllFilesToDetermineStructure" id="6577.ReadAllFilesToDetermineStructure" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6577.ReadAllFilesToDetermineStructure.bool"/>
      </Property>
      <Property name="ReadIds" id="6577.ReadIds" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6577.ReadIds.bool"/>
      </Property>
      <Property name="ReadQAAndInformationRecords" id="6577.ReadQAAndInformationRecords" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6577.ReadQAAndInformationRecords.bool"/>
      </Property>
      <Property name="RemoveUnusedPoints" id="6577.RemoveUnusedPoints" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6577.RemoveUnusedPoints.bool"/>
      </Property>
      <Property name="ScanForRelatedFiles" id="6577.ScanForRelatedFiles" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="6577.ScanForRelatedFiles.bool"/>
      </Property>
      <Property name="SideSetFieldInfo" id="6577.SideSetFieldInfo"/>
      <Property name="SideSetFields" id="6577.SideSetFields">
        <Domain name="array_list" id="6577.SideSetFields.array_list"/>
      </Property>
      <Property name="SideSetInfo" id="6577.SideSetInfo" number_of_elements="6">
        <Element index="0" value="gap_exit_boundary"/>
        <Element index="1" value="0"/>
        <Element index="2" value="gap_enter_boundary"/>
        <Element index="3" value="0"/>
        <Element index="4" value="wall"/>
        <Element index="5" value="0"/>
      </Property>
      <Property name="SideSets" id="6577.SideSets" number_of_elements="6">
        <Element index="0" value="gap_exit_boundary"/>
        <Element index="1" value="0"/>
        <Element index="2" value="gap_enter_boundary"/>
        <Element index="3" value="0"/>
        <Element index="4" value="wall"/>
        <Element index="5" value="0"/>
        <Domain name="array_list" id="6577.SideSets.array_list">
          <String text="gap_exit_boundary"/>
          <String text="gap_enter_boundary"/>
          <String text="wall"/>
        </Domain>
      </Property>
      <Property name="SideSetsIdInfo" id="6577.SideSetsIdInfo" number_of_elements="6">
        <Element index="0" value="gap_enter_boundary"/>
        <Element index="1" value="2"/>
        <Element index="2" value="gap_exit_boundary"/>
        <Element index="3" value="1"/>
        <Element index="4" value="wall"/>
        <Element index="5" value="3"/>
      </Property>
      <Property name="StructuredBlockFieldInfo" id="6577.StructuredBlockFieldInfo"/>
      <Property name="StructuredBlockFields" id="6577.StructuredBlockFields">
        <Domain name="array_list" id="6577.StructuredBlockFields.array_list"/>
      </Property>
      <Property name="StructuredBlockInfo" id="6577.StructuredBlockInfo"/>
      <Property name="StructuredBlocks" id="6577.StructuredBlocks">
        <Domain name="array_list" id="6577.StructuredBlocks.array_list"/>
      </Property>
      <Property name="StructuredBlocksIdInfo" id="6577.StructuredBlocksIdInfo"/>
      <Property name="TimestepValues" id="6577.TimestepValues" number_of_elements="1">
        <Element index="0" value="1"/>
      </Property>
    </Proxy>
    <Proxy group="misc" type="TimeKeeper" id="256" servers="16">
      <Property name="SuppressedTimeSources" id="256.SuppressedTimeSources"/>
      <Property name="Time" id="256.Time" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="256.Time.range"/>
      </Property>
      <Property name="TimeLabel" id="256.TimeLabel" number_of_elements="1">
        <Element index="0" value="Time"/>
      </Property>
      <Property name="TimeRange" id="256.TimeRange" number_of_elements="2">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
      </Property>
      <Property name="TimeSources" id="256.TimeSources" number_of_elements="2">
        <Proxy value="6577"/>
        <Proxy value="6975"/>
      </Property>
      <Property name="TimestepValues" id="256.TimestepValues" number_of_elements="1">
        <Element index="0" value="1"/>
      </Property>
      <Property name="Views" id="256.Views" number_of_elements="1">
        <Proxy value="326"/>
      </Property>
    </Proxy>
    <Proxy group="transfer_2d_functions" type="TransferFunction2D" id="6952" servers="21">
      <Property name="AutomaticRescaleRangeMode" id="6952.AutomaticRescaleRangeMode" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="6952.AutomaticRescaleRangeMode.enum">
          <Entry value="-1" text="Never"/>
          <Entry value="0" text="Grow and update on &#x27;Apply&#x27;"/>
          <Entry value="1" text="Grow and update every timestep"/>
          <Entry value="2" text="Update on &#x27;Apply&#x27;"/>
          <Entry value="3" text="Clamp and update every timestep"/>
        </Domain>
      </Property>
      <Property name="Boxes" id="6952.Boxes"/>
      <Property name="Build" id="6952.Build"/>
      <Property name="OutputDimensions" id="6952.OutputDimensions" number_of_elements="2">
        <Element index="0" value="10"/>
        <Element index="1" value="10"/>
      </Property>
      <Property name="Range" id="6952.Range" number_of_elements="4">
        <Element index="0" value="0"/>
        <Element index="1" value="1"/>
        <Element index="2" value="0"/>
        <Element index="3" value="1"/>
      </Property>
      <Property name="ScalarRangeInitialized" id="6952.ScalarRangeInitialized" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="6952.ScalarRangeInitialized.bool"/>
      </Property>
    </Proxy>
    <Proxy group="views" type="RenderView" id="326" servers="21">
      <Property name="ANARILibrary" id="326.ANARILibrary" number_of_elements="1">
        <Element index="0" value="visrtx"/>
        <Domain name="list" id="326.ANARILibrary.list">
          <String text="visrtx"/>
          <String text="helide"/>
          <String text="environment"/>
        </Domain>
      </Property>
      <Property name="ANARIRenderer" id="326.ANARIRenderer" number_of_elements="1">
        <Element index="0" value="default"/>
        <Domain name="list" id="326.ANARIRenderer.list"/>
      </Property>
      <Property name="ANARIRendererNames" id="326.ANARIRendererNames"/>
      <Property name="ANARIRendererParameter" id="326.ANARIRendererParameter" number_of_elements="3">
        <Element index="0" value=""/>
        <Element index="1" value=""/>
        <Element index="2" value=""/>
        <Domain name="json_list" id="326.ANARIRendererParameter.json_list"/>
      </Property>
      <Property name="ANARIRendererParametersInfo" id="326.ANARIRendererParametersInfo" number_of_elements="1">
        <Element index="0" value="{}"/>
      </Property>
      <Property name="AdditionalLights" id="326.AdditionalLights"/>
      <Property name="AlphaBitPlanes" id="326.AlphaBitPlanes" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="326.AlphaBitPlanes.bool"/>
      </Property>
      <Property name="AmbientSamples" id="326.AmbientSamples" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="326.AmbientSamples.range"/>
      </Property>
      <Property name="AnnotationColor" id="326.AnnotationColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
      </Property>
      <Property name="AxesGrid" id="326.AxesGrid" number_of_elements="1">
        <Proxy value="317"/>
        <Domain name="proxy_list" id="326.AxesGrid.proxy_list">
          <Proxy value="317"/>
        </Domain>
      </Property>
      <Property name="BackLightAzimuth" id="326.BackLightAzimuth" number_of_elements="1">
        <Element index="0" value="110"/>
        <Domain name="range" id="326.BackLightAzimuth.range"/>
      </Property>
      <Property name="BackLightElevation" id="326.BackLightElevation" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="326.BackLightElevation.range"/>
      </Property>
      <Property name="BackLightK:B Ratio" id="326.BackLightK:B Ratio" number_of_elements="1">
        <Element index="0" value="3.5"/>
        <Domain name="range" id="326.BackLightK:B Ratio.range"/>
      </Property>
      <Property name="BackLightWarmth" id="326.BackLightWarmth" number_of_elements="1">
        <Element index="0" value="0.5"/>
        <Domain name="range" id="326.BackLightWarmth.range"/>
      </Property>
      <Property name="Background" id="326.Background" number_of_elements="3">
        <Element index="0" value="0.384313725"/>
        <Element index="1" value="0.364705882"/>
        <Element index="2" value="0.352941176"/>
        <Domain name="range" id="326.Background.range"/>
      </Property>
      <Property name="Background2" id="326.Background2" number_of_elements="3">
        <Element index="0" value="0"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0.165"/>
        <Domain name="range" id="326.Background2.range"/>
      </Property>
      <Property name="BackgroundColorMode" id="326.BackgroundColorMode" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="326.BackgroundColorMode.enum">
          <Entry value="0" text="Single Color"/>
          <Entry value="1" text="Gradient"/>
          <Entry value="2" text="Texture"/>
          <Entry value="3" text="Skybox"/>
          <Entry value="4" text="Stereo Skybox"/>
        </Domain>
      </Property>
      <Property name="BackgroundEast" id="326.BackgroundEast" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0"/>
      </Property>
      <Property name="BackgroundMode" id="326.BackgroundMode" number_of_elements="1">
        <Element index="0" value="2"/>
        <Domain name="enum" id="326.BackgroundMode.enum">
          <Entry value="1" text="Backplate"/>
          <Entry value="2" text="Environment"/>
          <Entry value="3" text="Both"/>
        </Domain>
      </Property>
      <Property name="BackgroundNorth" id="326.BackgroundNorth" number_of_elements="3">
        <Element index="0" value="0"/>
        <Element index="1" value="1"/>
        <Element index="2" value="0"/>
      </Property>
      <Property name="BackgroundTexture" id="326.BackgroundTexture">
        <Domain name="groups" id="326.BackgroundTexture.groups"/>
      </Property>
      <Property name="Bias" id="326.Bias" number_of_elements="1">
        <Element index="0" value="0.01"/>
      </Property>
      <Property name="Blur" id="326.Blur" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="326.Blur.bool"/>
      </Property>
      <Property name="CacheKey" id="326.CacheKey" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="326.CacheKey.range"/>
      </Property>
      <Property name="Camera2DManipulators" id="326.Camera2DManipulators" number_of_elements="9">
        <Element index="0" value="1"/>
        <Element index="1" value="3"/>
        <Element index="2" value="2"/>
        <Element index="3" value="2"/>
        <Element index="4" value="2"/>
        <Element index="5" value="6"/>
        <Element index="6" value="3"/>
        <Element index="7" value="1"/>
        <Element index="8" value="4"/>
        <Domain name="enum" id="326.Camera2DManipulators.enum">
          <Entry value="0" text="None"/>
          <Entry value="1" text="Pan"/>
          <Entry value="2" text="Zoom"/>
          <Entry value="3" text="Roll"/>
          <Entry value="4" text="Rotate"/>
          <Entry value="6" text="ZoomToMouse"/>
        </Domain>
      </Property>
      <Property name="Camera2DMouseWheelMotionFactor" id="326.Camera2DMouseWheelMotionFactor" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="326.Camera2DMouseWheelMotionFactor.range"/>
      </Property>
      <Property name="Camera3DManipulators" id="326.Camera3DManipulators" number_of_elements="9">
        <Element index="0" value="4"/>
        <Element index="1" value="1"/>
        <Element index="2" value="2"/>
        <Element index="3" value="3"/>
        <Element index="4" value="4"/>
        <Element index="5" value="1"/>
        <Element index="6" value="7"/>
        <Element index="7" value="4"/>
        <Element index="8" value="6"/>
        <Domain name="enum" id="326.Camera3DManipulators.enum">
          <Entry value="0" text="None"/>
          <Entry value="1" text="Pan"/>
          <Entry value="2" text="Zoom"/>
          <Entry value="3" text="Roll"/>
          <Entry value="4" text="Rotate"/>
          <Entry value="5" text="Multi-Rotate"/>
          <Entry value="6" text="ZoomToMouse"/>
          <Entry value="7" text="SkyboxRotate"/>
        </Domain>
      </Property>
      <Property name="Camera3DMouseWheelMotionFactor" id="326.Camera3DMouseWheelMotionFactor" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="326.Camera3DMouseWheelMotionFactor.range"/>
      </Property>
      <Property name="CameraOrientationWidgetAnchor" id="326.CameraOrientationWidgetAnchor" number_of_elements="1">
        <Element index="0" value="3"/>
        <Domain name="enum" id="326.CameraOrientationWidgetAnchor.enum">
          <Entry value="1" text="Top Left"/>
          <Entry value="3" text="Top Right"/>
          <Entry value="0" text="Bottom Left"/>
          <Entry value="2" text="Bottom Right"/>
        </Domain>
      </Property>
      <Property name="CameraOrientationWidgetSize" id="326.CameraOrientationWidgetSize" number_of_elements="1">
        <Element index="0" value="100"/>
        <Domain name="range" id="326.CameraOrientationWidgetSize.range"/>
      </Property>
      <Property name="CameraOrientationWidgetVisibility" id="326.CameraOrientationWidgetVisibility" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="326.CameraOrientationWidgetVisibility.bool"/>
      </Property>
      <Property name="CameraParallelProjection" id="326.CameraParallelProjection" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="326.CameraParallelProjection.bool"/>
      </Property>
      <Property name="CaptureZBuffer" id="326.CaptureZBuffer"/>
      <Property name="CenterAxesVisibility" id="326.CenterAxesVisibility" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="326.CenterAxesVisibility.bool"/>
      </Property>
      <Property name="CenterAxesXColor" id="326.CenterAxesXColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0"/>
      </Property>
      <Property name="CenterAxesYColor" id="326.CenterAxesYColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="0"/>
      </Property>
      <Property name="CenterAxesZColor" id="326.CenterAxesZColor" number_of_elements="3">
        <Element index="0" value="0"/>
        <Element index="1" value="1"/>
        <Element index="2" value="0"/>
      </Property>
      <Property name="CenterOfRotation" id="326.CenterOfRotation" number_of_elements="3">
        <Element index="0" value="6.661338147750939e-16"/>
        <Element index="1" value="0"/>
        <Element index="2" value="-4.440892098500626e-16"/>
      </Property>
      <Property name="CollectGeometryThreshold" id="326.CollectGeometryThreshold" number_of_elements="1">
        <Element index="0" value="100"/>
      </Property>
      <Property name="CompressorConfig" id="326.CompressorConfig" number_of_elements="1">
        <Element index="0" value="vtkLZ4Compressor 0 3"/>
      </Property>
      <Property name="Contrast" id="326.Contrast" number_of_elements="1">
        <Element index="0" value="1.6773"/>
      </Property>
      <Property name="Denoise" id="326.Denoise" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="326.Denoise.bool"/>
      </Property>
      <Property name="DepthPeeling" id="326.DepthPeeling" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="326.DepthPeeling.bool"/>
      </Property>
      <Property name="DepthPeelingForVolumes" id="326.DepthPeelingForVolumes" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="326.DepthPeelingForVolumes.bool"/>
      </Property>
      <Property name="EnableANARI" id="326.EnableANARI" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="326.EnableANARI.bool"/>
      </Property>
      <Property name="EnableOSPRay" id="326.EnableOSPRay" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="326.EnableOSPRay.bool"/>
      </Property>
      <Property name="EnableRenderOnInteraction" id="326.EnableRenderOnInteraction" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="326.EnableRenderOnInteraction.bool"/>
      </Property>
      <Property name="EnableSynchronizableActors" id="326.EnableSynchronizableActors" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="326.EnableSynchronizableActors.bool"/>
      </Property>
      <Property name="EnvironmentalBG" id="326.EnvironmentalBG" number_of_elements="3">
        <Element index="0" value="0.384313725"/>
        <Element index="1" value="0.364705882"/>
        <Element index="2" value="0.352941176"/>
        <Domain name="range" id="326.EnvironmentalBG.range"/>
      </Property>
      <Property name="EnvironmentalBG2" id="326.EnvironmentalBG2" number_of_elements="3">
        <Element index="0" value="0"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0.165"/>
        <Domain name="range" id="326.EnvironmentalBG2.range"/>
      </Property>
      <Property name="EnvironmentalBGTexture" id="326.EnvironmentalBGTexture">
        <Domain name="groups" id="326.EnvironmentalBGTexture.groups"/>
      </Property>
      <Property name="Exposure" id="326.Exposure" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="326.Exposure.range"/>
      </Property>
      <Property name="FXAAEndpointSearchIterations" id="326.FXAAEndpointSearchIterations" number_of_elements="1">
        <Element index="0" value="12"/>
      </Property>
      <Property name="FXAAHardContrastThreshold" id="326.FXAAHardContrastThreshold" number_of_elements="1">
        <Element index="0" value="0.045"/>
      </Property>
      <Property name="FXAARelativeContrastThreshold" id="326.FXAARelativeContrastThreshold" number_of_elements="1">
        <Element index="0" value="0.125"/>
      </Property>
      <Property name="FXAASubpixelBlendLimit" id="326.FXAASubpixelBlendLimit" number_of_elements="1">
        <Element index="0" value="0.75"/>
      </Property>
      <Property name="FXAASubpixelContrastThreshold" id="326.FXAASubpixelContrastThreshold" number_of_elements="1">
        <Element index="0" value="0.25"/>
      </Property>
      <Property name="FXAAUseHighQualityEndpoints" id="326.FXAAUseHighQualityEndpoints" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="326.FXAAUseHighQualityEndpoints.bool"/>
      </Property>
      <Property name="FillLightAzimuth" id="326.FillLightAzimuth" number_of_elements="1">
        <Element index="0" value="-10"/>
        <Domain name="range" id="326.FillLightAzimuth.range"/>
      </Property>
      <Property name="FillLightElevation" id="326.FillLightElevation" number_of_elements="1">
        <Element index="0" value="-75"/>
        <Domain name="range" id="326.FillLightElevation.range"/>
      </Property>
      <Property name="FillLightK:F Ratio" id="326.FillLightK:F Ratio" number_of_elements="1">
        <Element index="0" value="3"/>
        <Domain name="range" id="326.FillLightK:F Ratio.range"/>
      </Property>
      <Property name="FillLightWarmth" id="326.FillLightWarmth" number_of_elements="1">
        <Element index="0" value="0.4"/>
        <Domain name="range" id="326.FillLightWarmth.range"/>
      </Property>
      <Property name="GenericFilmicPresets" id="326.GenericFilmicPresets" number_of_elements="1">
        <Element index="0" value="1"/>
      </Property>
      <Property name="HdrMax" id="326.HdrMax" number_of_elements="1">
        <Element index="0" value="11.0785"/>
      </Property>
      <Property name="HeadLightK:H Ratio" id="326.HeadLightK:H Ratio" number_of_elements="1">
        <Element index="0" value="3"/>
        <Domain name="range" id="326.HeadLightK:H Ratio.range"/>
      </Property>
      <Property name="HeadLightWarmth" id="326.HeadLightWarmth" number_of_elements="1">
        <Element index="0" value="0.5"/>
        <Domain name="range" id="326.HeadLightWarmth.range"/>
      </Property>
      <Property name="HiddenLineRemoval" id="326.HiddenLineRemoval" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="326.HiddenLineRemoval.bool"/>
      </Property>
      <Property name="ImageReductionFactor" id="326.ImageReductionFactor" number_of_elements="1">
        <Element index="0" value="2"/>
        <Domain name="range" id="326.ImageReductionFactor.range"/>
      </Property>
      <Property name="InteractionMode" id="326.InteractionMode" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="326.InteractionMode.enum">
          <Entry value="0" text="3D"/>
          <Entry value="1" text="2D"/>
          <Entry value="2" text="Selection"/>
        </Domain>
      </Property>
      <Property name="KernelSize" id="326.KernelSize" number_of_elements="1">
        <Element index="0" value="32"/>
      </Property>
      <Property name="KeyLightAzimuth" id="326.KeyLightAzimuth" number_of_elements="1">
        <Element index="0" value="10"/>
        <Domain name="range" id="326.KeyLightAzimuth.range"/>
      </Property>
      <Property name="KeyLightElevation" id="326.KeyLightElevation" number_of_elements="1">
        <Element index="0" value="50"/>
        <Domain name="range" id="326.KeyLightElevation.range"/>
      </Property>
      <Property name="KeyLightIntensity" id="326.KeyLightIntensity" number_of_elements="1">
        <Element index="0" value="0.75"/>
        <Domain name="range" id="326.KeyLightIntensity.range"/>
      </Property>
      <Property name="KeyLightWarmth" id="326.KeyLightWarmth" number_of_elements="1">
        <Element index="0" value="0.6"/>
        <Domain name="range" id="326.KeyLightWarmth.range"/>
      </Property>
      <Property name="LODResolution" id="326.LODResolution" number_of_elements="1">
        <Element index="0" value="0.5"/>
        <Domain name="range" id="326.LODResolution.range"/>
      </Property>
      <Property name="LODThreshold" id="326.LODThreshold" number_of_elements="1">
        <Element index="0" value="20"/>
        <Domain name="range" id="326.LODThreshold.range"/>
      </Property>
      <Property name="LegendGrid" id="326.LegendGrid" number_of_elements="1">
        <Proxy value="320"/>
        <Domain name="proxy_list" id="326.LegendGrid.proxy_list">
          <Proxy value="320"/>
        </Domain>
      </Property>
      <Property name="LightScale" id="326.LightScale" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="326.LightScale.range"/>
      </Property>
      <Property name="LockBounds" id="326.LockBounds" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="326.LockBounds.bool"/>
      </Property>
      <Property name="MaintainLuminance" id="326.MaintainLuminance" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="326.MaintainLuminance.bool"/>
      </Property>
      <Property name="MaxClipBounds" id="326.MaxClipBounds" number_of_elements="6">
        <Element index="0" value="0"/>
        <Element index="1" value="-1"/>
        <Element index="2" value="0"/>
        <Element index="3" value="-1"/>
        <Element index="4" value="0"/>
        <Element index="5" value="-1"/>
        <Domain name="range" id="326.MaxClipBounds.range"/>
      </Property>
      <Property name="MaxFrames" id="326.MaxFrames" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="326.MaxFrames.range"/>
      </Property>
      <Property name="MaximumNumberOfPeels" id="326.MaximumNumberOfPeels" number_of_elements="1">
        <Element index="0" value="4"/>
        <Domain name="range" id="326.MaximumNumberOfPeels.range"/>
      </Property>
      <Property name="MidIn" id="326.MidIn" number_of_elements="1">
        <Element index="0" value="0.18"/>
      </Property>
      <Property name="MidOut" id="326.MidOut" number_of_elements="1">
        <Element index="0" value="0.18"/>
      </Property>
      <Property name="MouseWheelZoomsToCursor" id="326.MouseWheelZoomsToCursor" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="326.MouseWheelZoomsToCursor.bool"/>
      </Property>
      <Property name="MultiSamples" id="326.MultiSamples" number_of_elements="1">
        <Element index="0" value="0"/>
      </Property>
      <Property name="NonInteractiveRenderDelay" id="326.NonInteractiveRenderDelay" number_of_elements="1">
        <Element index="0" value="0"/>
      </Property>
      <Property name="OSPRayMaterialLibrary" id="326.OSPRayMaterialLibrary" number_of_elements="1">
        <Proxy value="261"/>
      </Property>
      <Property name="OSPRayRendererType" id="326.OSPRayRendererType" number_of_elements="1">
        <Element index="0" value="OSPRay raycaster"/>
        <Domain name="list" id="326.OSPRayRendererType.list">
          <String text="OSPRay raycaster"/>
          <String text="OSPRay pathtracer"/>
        </Domain>
      </Property>
      <Property name="OSPRayTemporalCacheSize" id="326.OSPRayTemporalCacheSize" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="range" id="326.OSPRayTemporalCacheSize.range"/>
      </Property>
      <Property name="OrientationAxesInteractivity" id="326.OrientationAxesInteractivity" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="326.OrientationAxesInteractivity.bool"/>
      </Property>
      <Property name="OrientationAxesLabelColor" id="326.OrientationAxesLabelColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
      </Property>
      <Property name="OrientationAxesOutlineColor" id="326.OrientationAxesOutlineColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="1"/>
      </Property>
      <Property name="OrientationAxesVisibility" id="326.OrientationAxesVisibility" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="326.OrientationAxesVisibility.bool"/>
      </Property>
      <Property name="OrientationAxesXColor" id="326.OrientationAxesXColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0"/>
      </Property>
      <Property name="OrientationAxesXLabelText" id="326.OrientationAxesXLabelText" number_of_elements="1">
        <Element index="0" value="X"/>
      </Property>
      <Property name="OrientationAxesXVisibility" id="326.OrientationAxesXVisibility" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="326.OrientationAxesXVisibility.bool"/>
      </Property>
      <Property name="OrientationAxesYColor" id="326.OrientationAxesYColor" number_of_elements="3">
        <Element index="0" value="1"/>
        <Element index="1" value="1"/>
        <Element index="2" value="0"/>
      </Property>
      <Property name="OrientationAxesYLabelText" id="326.OrientationAxesYLabelText" number_of_elements="1">
        <Element index="0" value="Y"/>
      </Property>
      <Property name="OrientationAxesYVisibility" id="326.OrientationAxesYVisibility" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="326.OrientationAxesYVisibility.bool"/>
      </Property>
      <Property name="OrientationAxesZColor" id="326.OrientationAxesZColor" number_of_elements="3">
        <Element index="0" value="0"/>
        <Element index="1" value="1"/>
        <Element index="2" value="0"/>
      </Property>
      <Property name="OrientationAxesZLabelText" id="326.OrientationAxesZLabelText" number_of_elements="1">
        <Element index="0" value="Z"/>
      </Property>
      <Property name="OrientationAxesZVisibility" id="326.OrientationAxesZVisibility" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="326.OrientationAxesZVisibility.bool"/>
      </Property>
      <Property name="PPI" id="326.PPI" number_of_elements="1">
        <Element index="0" value="72"/>
      </Property>
      <Property name="PhysicalToWorldMatrix" id="326.PhysicalToWorldMatrix" number_of_elements="16">
        <Element index="0" value="1"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0"/>
        <Element index="3" value="0"/>
        <Element index="4" value="0"/>
        <Element index="5" value="1"/>
        <Element index="6" value="0"/>
        <Element index="7" value="0"/>
        <Element index="8" value="0"/>
        <Element index="9" value="0"/>
        <Element index="10" value="1"/>
        <Element index="11" value="0"/>
        <Element index="12" value="0"/>
        <Element index="13" value="0"/>
        <Element index="14" value="0"/>
        <Element index="15" value="1"/>
      </Property>
      <Property name="PolarGrid" id="326.PolarGrid" number_of_elements="1">
        <Proxy value="323"/>
        <Domain name="proxy_list" id="326.PolarGrid.proxy_list">
          <Proxy value="323"/>
        </Domain>
      </Property>
      <Property name="Radius" id="326.Radius" number_of_elements="1">
        <Element index="0" value="0.5"/>
      </Property>
      <Property name="RemoteRenderThreshold" id="326.RemoteRenderThreshold" number_of_elements="1">
        <Element index="0" value="20"/>
        <Domain name="range" id="326.RemoteRenderThreshold.range"/>
      </Property>
      <Property name="Representations" id="326.Representations" number_of_elements="3">
        <Proxy value="6919"/>
        <Proxy value="6960"/>
        <Proxy value="7217"/>
      </Property>
      <Property name="ReverseMouseWheelZoomDirection" id="326.ReverseMouseWheelZoomDirection" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="326.ReverseMouseWheelZoomDirection.bool"/>
      </Property>
      <Property name="RotationFactor" id="326.RotationFactor" number_of_elements="1">
        <Element index="0" value="1"/>
      </Property>
      <Property name="RouletteDepth" id="326.RouletteDepth" number_of_elements="1">
        <Element index="0" value="5"/>
        <Domain name="range" id="326.RouletteDepth.range"/>
      </Property>
      <Property name="SamplesPerPixel" id="326.SamplesPerPixel" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="326.SamplesPerPixel.range"/>
      </Property>
      <Property name="ServerStereoType" id="326.ServerStereoType" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="enum" id="326.ServerStereoType.enum">
          <Entry value="0" text="Same As Client"/>
          <Entry value="1" text="Crystal Eyes"/>
          <Entry value="2" text="Red-Blue"/>
          <Entry value="3" text="Interlaced"/>
          <Entry value="4" text="Left"/>
          <Entry value="5" text="Right"/>
          <Entry value="6" text="Dresden"/>
          <Entry value="7" text="Anaglyph"/>
          <Entry value="8" text="Checkerboard"/>
          <Entry value="9" text="SplitViewportHorizontal"/>
          <Entry value="10" text="None"/>
        </Domain>
      </Property>
      <Property name="SetHardwareSelector" id="326.SetHardwareSelector">
        <Domain name="groups" id="326.SetHardwareSelector.groups"/>
      </Property>
      <Property name="Shadows" id="326.Shadows" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="326.Shadows.bool"/>
      </Property>
      <Property name="Shoulder" id="326.Shoulder" number_of_elements="1">
        <Element index="0" value="0.9714"/>
      </Property>
      <Property name="ShowAnnotation" id="326.ShowAnnotation" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="326.ShowAnnotation.bool"/>
      </Property>
      <Property name="SkyboxRotation" id="326.SkyboxRotation" number_of_elements="3">
        <Element index="0" value="0"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0"/>
        <Domain name="range" id="326.SkyboxRotation.range"/>
      </Property>
      <Property name="SkyboxRotationInfo" id="326.SkyboxRotationInfo" number_of_elements="3">
        <Element index="0" value="0"/>
        <Element index="1" value="0"/>
        <Element index="2" value="0"/>
      </Property>
      <Property name="StencilCapable" id="326.StencilCapable" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="326.StencilCapable.bool"/>
      </Property>
      <Property name="StereoRender" id="326.StereoRender" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="326.StereoRender.bool"/>
      </Property>
      <Property name="StereoType" id="326.StereoType" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="enum" id="326.StereoType.enum">
          <Entry value="1" text="Crystal Eyes"/>
          <Entry value="2" text="Red-Blue"/>
          <Entry value="3" text="Interlaced"/>
          <Entry value="4" text="Left"/>
          <Entry value="5" text="Right"/>
          <Entry value="6" text="Dresden"/>
          <Entry value="7" text="Anaglyph"/>
          <Entry value="8" text="Checkerboard"/>
          <Entry value="9" text="SplitViewportHorizontal"/>
          <Entry value="10" text="None"/>
        </Domain>
      </Property>
      <Property name="StillRenderImageReductionFactor" id="326.StillRenderImageReductionFactor" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="326.StillRenderImageReductionFactor.range"/>
      </Property>
      <Property name="SuppressRendering" id="326.SuppressRendering" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="326.SuppressRendering.bool"/>
      </Property>
      <Property name="ToneMappingType" id="326.ToneMappingType" number_of_elements="1">
        <Element index="0" value="3"/>
      </Property>
      <Property name="UseACES" id="326.UseACES" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="326.UseACES.bool"/>
      </Property>
      <Property name="UseCache" id="326.UseCache" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="326.UseCache.bool"/>
      </Property>
      <Property name="UseColorPaletteForBackground" id="326.UseColorPaletteForBackground" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="326.UseColorPaletteForBackground.bool"/>
      </Property>
      <Property name="UseEnvironmentLighting" id="326.UseEnvironmentLighting" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="326.UseEnvironmentLighting.bool"/>
      </Property>
      <Property name="UseFXAA" id="326.UseFXAA" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="326.UseFXAA.bool"/>
      </Property>
      <Property name="UseGradientEnvironmentalBG" id="326.UseGradientEnvironmentalBG" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="326.UseGradientEnvironmentalBG.bool"/>
      </Property>
      <Property name="UseInteractiveRenderingForScreenshots" id="326.UseInteractiveRenderingForScreenshots" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="326.UseInteractiveRenderingForScreenshots.bool"/>
      </Property>
      <Property name="UseLight" id="326.UseLight" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="326.UseLight.bool"/>
      </Property>
      <Property name="UseOutlineForLODRendering" id="326.UseOutlineForLODRendering" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="326.UseOutlineForLODRendering.bool"/>
      </Property>
      <Property name="UseSSAO" id="326.UseSSAO" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="326.UseSSAO.bool"/>
      </Property>
      <Property name="UseSSAODefaultPresets" id="326.UseSSAODefaultPresets" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="bool" id="326.UseSSAODefaultPresets.bool"/>
      </Property>
      <Property name="UseTexturedEnvironmentalBG" id="326.UseTexturedEnvironmentalBG" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="326.UseTexturedEnvironmentalBG.bool"/>
      </Property>
      <Property name="UseToneMapping" id="326.UseToneMapping" number_of_elements="1">
        <Element index="0" value="0"/>
        <Domain name="bool" id="326.UseToneMapping.bool"/>
      </Property>
      <Property name="ViewSize" id="326.ViewSize" number_of_elements="2">
        <Element index="0" value="1290"/>
        <Element index="1" value="780"/>
      </Property>
      <Property name="ViewTime" id="326.ViewTime" number_of_elements="1">
        <Element index="0" value="1"/>
        <Domain name="range" id="326.ViewTime.range"/>
      </Property>
      <Property name="VolumeAnisotropy" id="326.VolumeAnisotropy" number_of_elements="1">
        <Element index="0" value="0"/>
      </Property>
      <Property name="WindowResizeNonInteractiveRenderDelay" id="326.WindowResizeNonInteractiveRenderDelay" number_of_elements="1">
        <Element index="0" value="0.3"/>
      </Property>
      <Property name="CameraFocalDisk" id="326.CameraFocalDisk" number_of_elements="1">
        <Element index="0" value="1"/>
      </Property>
      <Property name="CameraFocalDiskInfo" id="326.CameraFocalDiskInfo" number_of_elements="1">
        <Element index="0" value="1"/>
      </Property>
      <Property name="CameraFocalDistance" id="326.CameraFocalDistance" number_of_elements="1">
        <Element index="0" value="0"/>
      </Property>
      <Property name="CameraFocalDistanceInfo" id="326.CameraFocalDistanceInfo" number_of_elements="1">
        <Element index="0" value="0"/>
      </Property>
      <Property name="CameraFocalPoint" id="326.CameraFocalPoint" number_of_elements="3">
        <Element index="0" value="6.661338147750976e-16"/>
        <Element index="1" value="-1.746325928754913e-30"/>
        <Element index="2" value="-4.440892098500611e-16"/>
      </Property>
      <Property name="CameraFocalPointInfo" id="326.CameraFocalPointInfo" number_of_elements="3">
        <Element index="0" value="6.661338147750976e-16"/>
        <Element index="1" value="-1.746325928754913e-30"/>
        <Element index="2" value="-4.440892098500611e-16"/>
      </Property>
      <Property name="CameraParallelScale" id="326.CameraParallelScale" number_of_elements="1">
        <Element index="0" value="3.3268623703987696"/>
      </Property>
      <Property name="CameraParallelScaleInfo" id="326.CameraParallelScaleInfo" number_of_elements="1">
        <Element index="0" value="3.3268623703987696"/>
      </Property>
      <Property name="CameraPosition" id="326.CameraPosition" number_of_elements="3">
        <Element index="0" value="7.406789471083583"/>
        <Element index="1" value="2.5929863559862345"/>
        <Element index="2" value="3.936347338808126"/>
      </Property>
      <Property name="CameraPositionInfo" id="326.CameraPositionInfo" number_of_elements="3">
        <Element index="0" value="7.406789471083583"/>
        <Element index="1" value="2.5929863559862345"/>
        <Element index="2" value="3.936347338808126"/>
      </Property>
      <Property name="CameraViewAngle" id="326.CameraViewAngle" number_of_elements="1">
        <Element index="0" value="30"/>
      </Property>
      <Property name="CameraViewAngleInfo" id="326.CameraViewAngleInfo" number_of_elements="1">
        <Element index="0" value="30"/>
      </Property>
      <Property name="CameraViewUp" id="326.CameraViewUp" number_of_elements="3">
        <Element index="0" value="-0.5021514977663951"/>
        <Element index="1" value="0.7295889204991555"/>
        <Element index="2" value="0.46426703563342003"/>
      </Property>
      <Property name="CameraViewUpInfo" id="326.CameraViewUpInfo" number_of_elements="3">
        <Element index="0" value="-0.5021514977663951"/>
        <Element index="1" value="0.7295889204991555"/>
        <Element index="2" value="0.46426703563342003"/>
      </Property>
      <Property name="EyeAngle" id="326.EyeAngle" number_of_elements="1">
        <Element index="0" value="2"/>
        <Domain name="range" id="326.EyeAngle.range"/>
      </Property>
    </Proxy>
    <ProxyCollection name="animation">
      <Item id="263" name="AnimationScene1"/>
      <Item id="265" name="TimeAnimationCue1"/>
    </ProxyCollection>
    <ProxyCollection name="layouts">
      <Item id="327" name="Layout #1"/>
    </ProxyCollection>
    <ProxyCollection name="lookup_tables">
      <Item id="6953" name="vel.PVLookupTable" logname="lut-for-vel"/>
    </ProxyCollection>
    <ProxyCollection name="materiallibrary">
      <Item id="261" name="MaterialLibrary1"/>
    </ProxyCollection>
    <ProxyCollection name="piecewise_functions">
      <Item id="6951" name="vel.PiecewiseFunction"/>
    </ProxyCollection>
    <ProxyCollection name="pq_helper_proxies.326">
      <Item id="317" name="AxesGrid" logname="RenderView1/AxesGrid/GridAxes3DActor"/>
      <Item id="320" name="LegendGrid" logname="RenderView1/LegendGrid/LegendGridActor"/>
      <Item id="323" name="PolarGrid" logname="RenderView1/PolarGrid/PolarGridActor"/>
    </ProxyCollection>
    <ProxyCollection name="pq_helper_proxies.6577">
      <Item id="6589" name="RepresentationAnimationHelper"/>
    </ProxyCollection>
    <ProxyCollection name="pq_helper_proxies.6919">
      <Item id="6697" name="DataAxesGrid" logname="UnstructuredGridRepresentation1/DataAxesGrid/GridAxesRepresentation"/>
      <Item id="6734" name="GlyphType" logname="UnstructuredGridRepresentation1/Glyph3DRepresentation/GlyphType/ArrowSource"/>
      <Item id="6745" name="GlyphType" logname="UnstructuredGridRepresentation1/Glyph3DRepresentation/GlyphType/ConeSource"/>
      <Item id="6756" name="GlyphType" logname="UnstructuredGridRepresentation1/Glyph3DRepresentation/GlyphType/CubeSource"/>
      <Item id="6767" name="GlyphType" logname="UnstructuredGridRepresentation1/Glyph3DRepresentation/GlyphType/CylinderSource"/>
      <Item id="6778" name="GlyphType" logname="UnstructuredGridRepresentation1/Glyph3DRepresentation/GlyphType/LineSource"/>
      <Item id="6789" name="GlyphType" logname="UnstructuredGridRepresentation1/Glyph3DRepresentation/GlyphType/SphereSource"/>
      <Item id="6800" name="GlyphType" logname="UnstructuredGridRepresentation1/Glyph3DRepresentation/GlyphType/GlyphSource2D"/>
      <Item id="6811" name="GlyphType" logname="UnstructuredGridRepresentation1/Glyph3DRepresentation/GlyphType/PipelineConnection"/>
      <Item id="6890" name="OSPRayScaleFunction" logname="UnstructuredGridRepresentation1/SurfaceRepresentation/OSPRayScaleFunction/PiecewiseFunction"/>
      <Item id="6844" name="OpacityTransferFunction" logname="UnstructuredGridRepresentation1/PointGaussianRepresentation/OpacityTransferFunction/PiecewiseFunction"/>
      <Item id="6712" name="PolarAxes" logname="UnstructuredGridRepresentation1/PolarAxes/PolarAxesRepresentation"/>
      <Item id="6845" name="ScaleTransferFunction" logname="UnstructuredGridRepresentation1/PointGaussianRepresentation/ScaleTransferFunction/PiecewiseFunction"/>
      <Item id="6891" name="TextureTransform" logname="UnstructuredGridRepresentation1/SurfaceRepresentation/TextureTransform/Transform2"/>
    </ProxyCollection>
    <ProxyCollection name="pq_helper_proxies.6975">
      <Item id="6986" name="RepresentationAnimationHelper"/>
    </ProxyCollection>
    <ProxyCollection name="pq_helper_proxies.7217">
      <Item id="6995" name="DataAxesGrid" logname="UnstructuredGridRepresentation2/DataAxesGrid/GridAxesRepresentation"/>
      <Item id="7032" name="GlyphType" logname="UnstructuredGridRepresentation2/Glyph3DRepresentation/GlyphType/ArrowSource"/>
      <Item id="7043" name="GlyphType" logname="UnstructuredGridRepresentation2/Glyph3DRepresentation/GlyphType/ConeSource"/>
      <Item id="7054" name="GlyphType" logname="UnstructuredGridRepresentation2/Glyph3DRepresentation/GlyphType/CubeSource"/>
      <Item id="7065" name="GlyphType" logname="UnstructuredGridRepresentation2/Glyph3DRepresentation/GlyphType/CylinderSource"/>
      <Item id="7076" name="GlyphType" logname="UnstructuredGridRepresentation2/Glyph3DRepresentation/GlyphType/LineSource"/>
      <Item id="7087" name="GlyphType" logname="UnstructuredGridRepresentation2/Glyph3DRepresentation/GlyphType/SphereSource"/>
      <Item id="7098" name="GlyphType" logname="UnstructuredGridRepresentation2/Glyph3DRepresentation/GlyphType/GlyphSource2D"/>
      <Item id="7109" name="GlyphType" logname="UnstructuredGridRepresentation2/Glyph3DRepresentation/GlyphType/PipelineConnection"/>
      <Item id="7188" name="OSPRayScaleFunction" logname="UnstructuredGridRepresentation2/SurfaceRepresentation/OSPRayScaleFunction/PiecewiseFunction"/>
      <Item id="7142" name="OpacityTransferFunction" logname="UnstructuredGridRepresentation2/PointGaussianRepresentation/OpacityTransferFunction/PiecewiseFunction"/>
      <Item id="7010" name="PolarAxes" logname="UnstructuredGridRepresentation2/PolarAxes/PolarAxesRepresentation"/>
      <Item id="7143" name="ScaleTransferFunction" logname="UnstructuredGridRepresentation2/PointGaussianRepresentation/ScaleTransferFunction/PiecewiseFunction"/>
      <Item id="7189" name="TextureTransform" logname="UnstructuredGridRepresentation2/SurfaceRepresentation/TextureTransform/Transform2"/>
    </ProxyCollection>
    <ProxyCollection name="representations">
      <Item id="6919" name="UnstructuredGridRepresentation1" logname="UnstructuredGridRepresentation1"/>
      <Item id="7217" name="UnstructuredGridRepresentation2" logname="UnstructuredGridRepresentation2"/>
    </ProxyCollection>
    <ProxyCollection name="scalar_bars">
      <Item id="6960" name="ScalarBarWidgetRepresentation1"/>
    </ProxyCollection>
    <ProxyCollection name="settings">
      <Item id="267" name="ColorPalette"/>
    </ProxyCollection>
    <ProxyCollection name="sources">
      <Item id="6975" name="Threshold1" logname="Threshold1"/>
      <Item id="6577" name="th_phase1_from_th_exodus_out.e" logname="th_phase1_from_th_exodus_out.e"/>
    </ProxyCollection>
    <ProxyCollection name="timekeeper">
      <Item id="256" name="TimeKeeper1"/>
    </ProxyCollection>
    <ProxyCollection name="transfer_2d_functions">
      <Item id="6952" name="vel.TransferFunction2D" logname="tf2d-for-vel"/>
    </ProxyCollection>
    <ProxyCollection name="views">
      <Item id="326" name="RenderView1" logname="RenderView1"/>
    </ProxyCollection>
    <CustomProxyDefinitions/>
    <Links/>
    <Settings>
      <SettingsProxy group="settings" type="ColorPalette">
        <Links>
          <Property source_property="ForegroundColor" target_id="317" target_property="GridColor" unlink_if_modified="1"/>
          <Property source_property="TextAnnotationColor" target_id="317" target_property="XLabelColor" unlink_if_modified="1"/>
          <Property source_property="TextAnnotationColor" target_id="317" target_property="XTitleColor" unlink_if_modified="1"/>
          <Property source_property="TextAnnotationColor" target_id="317" target_property="YLabelColor" unlink_if_modified="1"/>
          <Property source_property="TextAnnotationColor" target_id="317" target_property="YTitleColor" unlink_if_modified="1"/>
          <Property source_property="TextAnnotationColor" target_id="317" target_property="ZLabelColor" unlink_if_modified="1"/>
          <Property source_property="TextAnnotationColor" target_id="317" target_property="ZTitleColor" unlink_if_modified="1"/>
          <Property source_property="TextAnnotationColor" target_id="320" target_property="LegendLabelColor" unlink_if_modified="1"/>
          <Property source_property="TextAnnotationColor" target_id="323" target_property="AxesLabelColor" unlink_if_modified="1"/>
          <Property source_property="TextAnnotationColor" target_id="326" target_property="AnnotationColor" unlink_if_modified="1"/>
          <Property source_property="TextAnnotationColor" target_id="326" target_property="OrientationAxesLabelColor" unlink_if_modified="1"/>
          <Property source_property="ForegroundColor" target_id="326" target_property="OrientationAxesOutlineColor" unlink_if_modified="1"/>
          <Property source_property="ForegroundColor" target_id="6697" target_property="GridColor" unlink_if_modified="1"/>
          <Property source_property="TextAnnotationColor" target_id="6697" target_property="XLabelColor" unlink_if_modified="1"/>
          <Property source_property="TextAnnotationColor" target_id="6697" target_property="XTitleColor" unlink_if_modified="1"/>
          <Property source_property="TextAnnotationColor" target_id="6697" target_property="YLabelColor" unlink_if_modified="1"/>
          <Property source_property="TextAnnotationColor" target_id="6697" target_property="YTitleColor" unlink_if_modified="1"/>
          <Property source_property="TextAnnotationColor" target_id="6697" target_property="ZLabelColor" unlink_if_modified="1"/>
          <Property source_property="TextAnnotationColor" target_id="6697" target_property="ZTitleColor" unlink_if_modified="1"/>
          <Property source_property="TextAnnotationColor" target_id="6712" target_property="LastRadialAxisTextColor" unlink_if_modified="1"/>
          <Property source_property="TextAnnotationColor" target_id="6712" target_property="PolarAxisLabelColor" unlink_if_modified="1"/>
          <Property source_property="TextAnnotationColor" target_id="6712" target_property="PolarAxisTitleColor" unlink_if_modified="1"/>
          <Property source_property="TextAnnotationColor" target_id="6712" target_property="SecondaryRadialAxesTextColor" unlink_if_modified="1"/>
          <Property source_property="ForegroundColor" target_id="6919" target_property="AmbientColor" unlink_if_modified="1"/>
          <Property source_property="SurfaceColor" target_id="6919" target_property="BackfaceDiffuseColor" unlink_if_modified="1"/>
          <Property source_property="SurfaceColor" target_id="6919" target_property="DiffuseColor" unlink_if_modified="1"/>
          <Property source_property="EdgeColor" target_id="6919" target_property="EdgeColor" unlink_if_modified="1"/>
          <Property source_property="InteractiveSelectionColor" target_id="6919" target_property="InteractiveSelectionColor" unlink_if_modified="1"/>
          <Property source_property="SelectionColor" target_id="6919" target_property="SelectionColor" unlink_if_modified="1"/>
          <Property source_property="TextAnnotationColor" target_id="6960" target_property="LabelColor" unlink_if_modified="1"/>
          <Property source_property="TextAnnotationColor" target_id="6960" target_property="TitleColor" unlink_if_modified="1"/>
          <Property source_property="ForegroundColor" target_id="6995" target_property="GridColor" unlink_if_modified="1"/>
          <Property source_property="TextAnnotationColor" target_id="6995" target_property="XLabelColor" unlink_if_modified="1"/>
          <Property source_property="TextAnnotationColor" target_id="6995" target_property="XTitleColor" unlink_if_modified="1"/>
          <Property source_property="TextAnnotationColor" target_id="6995" target_property="YLabelColor" unlink_if_modified="1"/>
          <Property source_property="TextAnnotationColor" target_id="6995" target_property="YTitleColor" unlink_if_modified="1"/>
          <Property source_property="TextAnnotationColor" target_id="6995" target_property="ZLabelColor" unlink_if_modified="1"/>
          <Property source_property="TextAnnotationColor" target_id="6995" target_property="ZTitleColor" unlink_if_modified="1"/>
          <Property source_property="TextAnnotationColor" target_id="7010" target_property="LastRadialAxisTextColor" unlink_if_modified="1"/>
          <Property source_property="TextAnnotationColor" target_id="7010" target_property="PolarAxisLabelColor" unlink_if_modified="1"/>
          <Property source_property="TextAnnotationColor" target_id="7010" target_property="PolarAxisTitleColor" unlink_if_modified="1"/>
          <Property source_property="TextAnnotationColor" target_id="7010" target_property="SecondaryRadialAxesTextColor" unlink_if_modified="1"/>
          <Property source_property="ForegroundColor" target_id="7217" target_property="AmbientColor" unlink_if_modified="1"/>
          <Property source_property="SurfaceColor" target_id="7217" target_property="BackfaceDiffuseColor" unlink_if_modified="1"/>
          <Property source_property="SurfaceColor" target_id="7217" target_property="DiffuseColor" unlink_if_modified="1"/>
          <Property source_property="EdgeColor" target_id="7217" target_property="EdgeColor" unlink_if_modified="1"/>
          <Property source_property="InteractiveSelectionColor" target_id="7217" target_property="InteractiveSelectionColor" unlink_if_modified="1"/>
          <Property source_property="SelectionColor" target_id="7217" target_property="SelectionColor" unlink_if_modified="1"/>
        </Links>
      </SettingsProxy>
      <SettingsProxy group="settings" type="GeneralSettings">
        <Links>
          <Property source_property="ScreenPixelsPerInch" target_id="326" target_property="PPI" unlink_if_modified="0"/>
          <Property source_property="BlockColorsDistinctValues" target_id="6919" target_property="BlockColorsDistinctValues" unlink_if_modified="0"/>
          <Property source_property="MaximumNumberOfDataRepresentationLabels" target_id="6919" target_property="SelectionMaximumNumberOfLabels" unlink_if_modified="0"/>
          <Property source_property="BlockColorsDistinctValues" target_id="7217" target_property="BlockColorsDistinctValues" unlink_if_modified="0"/>
          <Property source_property="MaximumNumberOfDataRepresentationLabels" target_id="7217" target_property="SelectionMaximumNumberOfLabels" unlink_if_modified="0"/>
        </Links>
      </SettingsProxy>
      <SettingsProxy group="settings" type="IOSettings">
        <Links/>
      </SettingsProxy>
      <SettingsProxy group="settings" type="RenderViewInteractionSettings">
        <Links>
          <Property source_property="Camera2DManipulators" target_id="326" target_property="Camera2DManipulators" unlink_if_modified="0"/>
          <Property source_property="Camera2DMouseWheelMotionFactor" target_id="326" target_property="Camera2DMouseWheelMotionFactor" unlink_if_modified="0"/>
          <Property source_property="Camera3DManipulators" target_id="326" target_property="Camera3DManipulators" unlink_if_modified="0"/>
          <Property source_property="Camera3DMouseWheelMotionFactor" target_id="326" target_property="Camera3DMouseWheelMotionFactor" unlink_if_modified="0"/>
          <Property source_property="MouseWheelZoomsToCursor" target_id="326" target_property="MouseWheelZoomsToCursor" unlink_if_modified="0"/>
          <Property source_property="ReverseMouseWheelZoomDirection" target_id="326" target_property="ReverseMouseWheelZoomDirection" unlink_if_modified="0"/>
        </Links>
      </SettingsProxy>
      <SettingsProxy group="settings" type="RenderViewSettings">
        <Links>
          <Property source_property="Bias" target_id="326" target_property="Bias" unlink_if_modified="0"/>
          <Property source_property="Blur" target_id="326" target_property="Blur" unlink_if_modified="0"/>
          <Property source_property="CompressorConfig" target_id="326" target_property="CompressorConfig" unlink_if_modified="0"/>
          <Property source_property="Contrast" target_id="326" target_property="Contrast" unlink_if_modified="0"/>
          <Property source_property="DepthPeeling" target_id="326" target_property="DepthPeeling" unlink_if_modified="0"/>
          <Property source_property="DepthPeelingForVolumes" target_id="326" target_property="DepthPeelingForVolumes" unlink_if_modified="0"/>
          <Property source_property="FXAAEndpointSearchIterations" target_id="326" target_property="FXAAEndpointSearchIterations" unlink_if_modified="0"/>
          <Property source_property="FXAAHardContrastThreshold" target_id="326" target_property="FXAAHardContrastThreshold" unlink_if_modified="0"/>
          <Property source_property="FXAARelativeContrastThreshold" target_id="326" target_property="FXAARelativeContrastThreshold" unlink_if_modified="0"/>
          <Property source_property="FXAASubpixelBlendLimit" target_id="326" target_property="FXAASubpixelBlendLimit" unlink_if_modified="0"/>
          <Property source_property="FXAASubpixelContrastThreshold" target_id="326" target_property="FXAASubpixelContrastThreshold" unlink_if_modified="0"/>
          <Property source_property="FXAAUseHighQualityEndpoints" target_id="326" target_property="FXAAUseHighQualityEndpoints" unlink_if_modified="0"/>
          <Property source_property="GenericFilmicPresets" target_id="326" target_property="GenericFilmicPresets" unlink_if_modified="0"/>
          <Property source_property="HdrMax" target_id="326" target_property="HdrMax" unlink_if_modified="0"/>
          <Property source_property="ImageReductionFactor" target_id="326" target_property="ImageReductionFactor" unlink_if_modified="0"/>
          <Property source_property="KernelSize" target_id="326" target_property="KernelSize" unlink_if_modified="0"/>
          <Property source_property="LODResolution" target_id="326" target_property="LODResolution" unlink_if_modified="0"/>
          <Property source_property="LODThreshold" target_id="326" target_property="LODThreshold" unlink_if_modified="0"/>
          <Property source_property="MaximumNumberOfPeels" target_id="326" target_property="MaximumNumberOfPeels" unlink_if_modified="0"/>
          <Property source_property="MidIn" target_id="326" target_property="MidIn" unlink_if_modified="0"/>
          <Property source_property="MidOut" target_id="326" target_property="MidOut" unlink_if_modified="0"/>
          <Property source_property="NonInteractiveRenderDelay" target_id="326" target_property="NonInteractiveRenderDelay" unlink_if_modified="0"/>
          <Property source_property="Radius" target_id="326" target_property="Radius" unlink_if_modified="0"/>
          <Property source_property="RemoteRenderThreshold" target_id="326" target_property="RemoteRenderThreshold" unlink_if_modified="0"/>
          <Property source_property="Shoulder" target_id="326" target_property="Shoulder" unlink_if_modified="0"/>
          <Property source_property="ShowAnnotation" target_id="326" target_property="ShowAnnotation" unlink_if_modified="0"/>
          <Property source_property="StillRenderImageReductionFactor" target_id="326" target_property="StillRenderImageReductionFactor" unlink_if_modified="0"/>
          <Property source_property="ToneMappingType" target_id="326" target_property="ToneMappingType" unlink_if_modified="0"/>
          <Property source_property="UseACES" target_id="326" target_property="UseACES" unlink_if_modified="0"/>
          <Property source_property="UseFXAA" target_id="326" target_property="UseFXAA" unlink_if_modified="0"/>
          <Property source_property="UseOutlineForLODRendering" target_id="326" target_property="UseOutlineForLODRendering" unlink_if_modified="0"/>
          <Property source_property="UseSSAODefaultPresets" target_id="326" target_property="UseSSAODefaultPresets" unlink_if_modified="0"/>
          <Property source_property="WindowResizeNonInteractiveRenderDelay" target_id="326" target_property="WindowResizeNonInteractiveRenderDelay" unlink_if_modified="0"/>
        </Links>
      </SettingsProxy>
      <SettingsProxy group="settings" type="RepresentedArrayListSettings">
        <Links/>
      </SettingsProxy>
    </Settings>
  </ServerManagerState>
  <InteractiveViewLinks/>
  <CameraWidgetViewLinks/>
</ParaView>

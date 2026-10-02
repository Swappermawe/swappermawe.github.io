

const scriptsInEvents = {

	async списоксобытий1_Event85_Act1(runtime, localVars)
	{
		runtime.objects.misha.getFirstInstance().behaviors.bto.wrapTo = 0;
		
	},

	async Run_Event88_Act1(runtime, localVars)
	{
		runtime.objects.misha.getFirstInstance().behaviors.bto.wrapTo = 0;
		
	},

	async Run_Event97(runtime, localVars)
	{
		const isMobile = runtime.platformInfo.isMobile;
		const layer = runtime.layout.getLayer("Layer 3");
		
		if (layer) {
		    if (isMobile) {
		        layer.isVisible = true;
		        layer.isInteractable = true; 
		    } else {
		        layer.isVisible = false;
		        layer.isInteractable = false;
		    }
		}
		
	}
};

globalThis.C3.JavaScriptInEvents = scriptsInEvents;

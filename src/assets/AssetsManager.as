package assets
{
    import flash.display.Loader;
    import flash.display.LoaderInfo;
    import flash.display.Sprite;
    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.system.ApplicationDomain;
    import flash.system.LoaderContext;
    import flash.utils.ByteArray;
    import com.hexagonstar.util.debug.Debug;
        
    public class AssetsManager
    {
        [Embed(source='../../assets/Assets.swf', mimeType="application/octet-stream")] 
        private var Assets:Class;

        private static var assetsLoader:Loader;
        private static var assetsContainer:LoaderInfo;
        private static var callbackFunction:Function;
        
        public function AssetsManager(callbackFunction:Function)
        {
            Debug.trace('constructor');
            
            AssetsManager.callbackFunction = callbackFunction;
            assetsLoader = new Loader();
            assetsLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, assetsLoaded);
            assetsLoader.loadBytes(new Assets() as ByteArray, new LoaderContext(false, ApplicationDomain.currentDomain)); 
            Debug.trace('load sent');
        }

        public static function assetsLoaded(event:Event):void
        {
            Debug.trace('loaded');
            assetsContainer = event.currentTarget as LoaderInfo;
            callbackFunction.call(null);
        }
        
        public static function getAsset(className:String):*
        {
            if (assetsContainer == null) throw new Error("[Resources] The Asset container has not been initialized");
            else
            {
                var classOfAsset:Class = assetsContainer.applicationDomain.getDefinition("Assets_" + className) as Class;
                if (classOfAsset == null) throw new Error("The class " + className + " does not exist in the Assets container.");
                var instancedClass:* = new classOfAsset();
                if (instancedClass is Sprite || instancedClass is MovieClip) return instancedClass;
                else
                {
                    var returnSprite:Sprite = new Sprite();
                    returnSprite.addChild(instancedClass);
                    return returnSprite;
                }
                return instancedClass;
            }
            
            return null;
        }
    } 
}

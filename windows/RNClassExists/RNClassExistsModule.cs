using ReactNative.Bridge;
using System;
using System.Collections.Generic;
using Windows.ApplicationModel.Core;
using Windows.UI.Core;

namespace Com.Reactlibrary.RNClassExists
{
    /// <summary>
    /// A module that allows JS to share data.
    /// </summary>
    class RNClassExistsModule : NativeModuleBase
    {
        /// <summary>
        /// Instantiates the <see cref="RNClassExistsModule"/>.
        /// </summary>
        internal RNClassExistsModule()
        {

        }

        /// <summary>
        /// The name of the native module.
        /// </summary>
        public override string Name
        {
            get
            {
                return "RNClassExists";
            }
        }
    }
}
